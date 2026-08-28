import firebase_admin
from firebase_admin import credentials, firestore
import json
import hashlib
import sys

# ==============================================================================
# CONFIGURATION
# ==============================================================================
SERVICE_ACCOUNT_PATH = 'serviceAccountKey.json'
JSON_DATA_PATH = 'bulk_questions.json'  # Change to 'competitive_questions.json' as needed
DRY_RUN = False  # Set to True to test without uploading
SKIP_EXISTING = True  # If True, don't even update existing questions to save writes

# ==============================================================================
# UPLOADER LOGIC
# ==============================================================================

def setup_firebase():
    try:
        cred = credentials.Certificate(SERVICE_ACCOUNT_PATH)
        firebase_admin.initialize_app(cred)
        return firestore.client()
    except Exception as e:
        print(f"ERROR: Could not initialize Firebase. Ensure '{SERVICE_ACCOUNT_PATH}' exists.")
        print(f"Details: {e}")
        sys.exit(1)

def generate_id_from_text(text):
    """Creates a unique deterministic ID based on the question text."""
    # Normalize text: lowercase and remove extra whitespace
    normalized = " ".join(text.lower().split())
    return hashlib.sha256(normalized.encode()).hexdigest()[:20]

def upload_questions(db, data_path):
    with open(data_path, 'r') as f:
        questions = json.load(f)

    print(f"--- Starting Smart Upload: {len(questions)} items found ---")

    batch = db.batch()
    processed_count = 0
    new_count = 0
    skipped_count = 0
    stats = {"practice": 0, "competitive": 0, "general": 0}

    # Fetch existing IDs to avoid redundant writes if SKIP_EXISTING is True
    existing_ids = set()
    if SKIP_EXISTING:
        print("Checking for existing questions in Firestore...")
        docs = db.collection('questions').select([]).get()
        existing_ids = {doc.id for doc in docs}
        print(f"Found {len(existing_ids)} existing questions.")

    for q in questions:
        # 1. Generate Deterministic ID from Text
        doc_id = q.get('id') or generate_id_from_text(q['text'])
        
        if SKIP_EXISTING and doc_id in existing_ids:
            skipped_count += 1
            continue

        doc_ref = db.collection('questions').document(doc_id)

        # 2. Modes Tracking (for logs)
        tags = q.get('tags', [])
        if "practice" in tags: stats["practice"] += 1
        if "competitive" in tags: stats["competitive"] += 1
        if not tags: stats["general"] += 1

        # 3. Timestamps
        q['createdAt'] = firestore.SERVER_TIMESTAMP
        q['updatedAt'] = firestore.SERVER_TIMESTAMP
        
        # 4. Cleanup
        if 'id' in q: del q['id']

        if not DRY_RUN:
            batch.set(doc_ref, q, merge=True)
        
        processed_count += 1
        new_count += 1

        # Commit in chunks of 500 (Firestore limit)
        if processed_count % 500 == 0:
            if not DRY_RUN:
                batch.commit()
                batch = db.batch()
            print(f"Progress: {processed_count} processed...")

    if not DRY_RUN:
        batch.commit()
        print("\nSUCCESS: Sync complete.")
    else:
        print("\nDRY RUN COMPLETE: No data was written.")

    print("\n--- Summary ---")
    print(f"Total in File: {len(questions)}")
    print(f"New / Updated: {new_count}")
    print(f"Skipped (Already in Firebase): {skipped_count}")
    print(f"--- Breakdown of New Items ---")
    print(f"  - Practice: {stats['practice']}")
    print(f"  - Competitive: {stats['competitive']}")
    print(f"  - General: {stats['general']}")

if __name__ == "__main__":
    firestore_db = setup_firebase()
    upload_questions(firestore_db, JSON_DATA_PATH)
