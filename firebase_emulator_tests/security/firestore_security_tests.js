const testing = require('@firebase/rules-unit-testing');
const fs = require('fs');

/**
 * FIREBASE EMULATOR SECURITY TESTS
 *
 * To run:
 * 1. Start emulator: firebase emulators:start
 * 2. Run tests: npm test
 */

const PROJECT_ID = 'soteria-security-test';
const RULES = fs.readFileSync('firebase/firestore.rules', 'utf8');

describe('Firestore Security Rules', () => {

  before(async () => {
    await testing.loadFirestoreRules({
      projectId: PROJECT_ID,
      rules: RULES,
    });
  });

  beforeEach(async () => {
    await testing.clearFirestoreData({ projectId: PROJECT_ID });
  });

  after(async () => {
    await Promise.all(testing.apps().map(app => app.delete()));
  });

  function getFirestore(auth) {
    return testing.initializeTestApp({
      projectId: PROJECT_ID,
      auth: auth,
    }).firestore();
  }

  function getAdminFirestore() {
    return testing.initializeAdminApp({
      projectId: PROJECT_ID,
    }).firestore();
  }

  // --- USERS COLLECTION TESTS ---

  it('should allow user to read their own profile', async () => {
    const db = getFirestore({ uid: 'alice' });
    const profile = db.collection('users').doc('alice');
    await testing.assertSucceeds(profile.get());
  });

  it('should deny user from reading another profile', async () => {
    const db = getFirestore({ uid: 'alice' });
    const profile = db.collection('users').doc('bob');
    await testing.assertFails(profile.get());
  });

  it('should allow user to bootstrap their own profile with level 1', async () => {
    const db = getFirestore({ uid: 'alice' });
    const profile = db.collection('users').doc('alice');
    await testing.assertSucceeds(profile.set({
      level: 1,
      xp: 0,
      coins: 0,
      role: 'user',
      accountStatus: 'active',
      displayName: 'Alice',
      email: 'alice@soteria.com',
      createdAt: new Date(),
      lastLogin: new Date(),
      updatedAt: new Date()
    }));
  });

  it('should deny user from bootstrapping with role: admin', async () => {
    const db = getFirestore({ uid: 'alice' });
    const profile = db.collection('users').doc('alice');
    await testing.assertFails(profile.set({
      level: 1,
      xp: 0,
      coins: 0,
      role: 'admin',
      accountStatus: 'active'
    }));
  });

  it('should deny user from updating XP', async () => {
    const adminDb = getAdminFirestore();
    await adminDb.collection('users').doc('alice').set({
      xp: 100,
      displayName: 'Alice'
    });

    const db = getFirestore({ uid: 'alice' });
    const profile = db.collection('users').doc('alice');
    await testing.assertFails(profile.update({ xp: 9999 }));
  });

  it('should allow user to update displayName', async () => {
    const adminDb = getAdminFirestore();
    await adminDb.collection('users').doc('alice').set({
      displayName: 'OldName'
    });

    const db = getFirestore({ uid: 'alice' });
    const profile = db.collection('users').doc('alice');
    await testing.assertSucceeds(profile.update({ displayName: 'NewName' }));
  });

  // --- READ-ONLY COLLECTIONS TESTS ---

  it('should deny user from writing to questions', async () => {
    const db = getFirestore({ uid: 'alice' });
    const question = db.collection('questions').doc('q1');
    await testing.assertFails(question.set({ text: 'Cheat?' }));
  });

  it('should allow authenticated user to read questions', async () => {
    const db = getFirestore({ uid: 'alice' });
    const question = db.collection('questions').doc('q1');
    await testing.assertSucceeds(question.get());
  });

  it('should allow anyone to read announcements', async () => {
    const db = getFirestore(null);
    const announcement = db.collection('announcements').doc('a1');
    await testing.assertSucceeds(announcement.get());
  });
});
