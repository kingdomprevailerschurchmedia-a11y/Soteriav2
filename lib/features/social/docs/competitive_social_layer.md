# Competitive Social Layer - Soteria

The Competitive Social Layer allows players to discover, connect with, follow, and compete against other Soteria players. It is designed to enhance competition and motivation without becoming a generic social network.

## Architecture

The social layer is built as a separate feature that integrates deeply with the `player` (identity/profile) and `notifications` systems.

### Core Components

- **SocialRepository**: Manages friendships, follow relationships, and blocking using Firestore.
- **SocialProviders**: Reactive Riverpod providers for friends lists, pending requests, and relationship status.
- **SocialController**: StateNotifier for executing social actions (send request, accept, etc.).

## Data Models

- **RelationshipStatus**: Enum defining the connection state between two players (`none`, `requestSent`, `requestReceived`, `friends`, `blocked`).
- **Friendship**: A bi-directional connection between two users.
- **FriendRequest**: A pending invitation to connect.
- **Follow**: A one-way interest relationship.
- **CompetitiveActivityEvent**: Authoritative events surfaced in the social and competitive feeds.

## Firestore Schema

### `friendships` (Collection)
- `userIds`: `Array<String>` (length 2)
- `createdAt`: `Timestamp`

### `friend_requests` (Collection)
- `senderId`: `String`
- `receiverId`: `String`
- `status`: `String` (`pending`, `accepted`, `declined`, `cancelled`)
- `createdAt`: `Timestamp`

### `follows` (Collection)
- `followerId`: `String`
- `followingId`: `String`
- `createdAt`: `Timestamp`

## Security & Privacy

- **User Isolation**: Firestore rules ensure users can only modify their own requests and relationships.
- **Idempotency**: All operations (send request, accept, etc.) are designed to be idempotent on the backend.
- **Privacy Settings**: (Future) Control who can see activity and send requests.

## Integration

- **Public Profile**: Displays context-aware action buttons based on `RelationshipStatus`.
- **Friends List**: Direct access to challenges and profile viewing.
- **Search**: Integrated into the existing `PlayerSearchScreen`.
- **Notifications**: Friend events trigger `AppNotification` events.

## Preview System

Use the `SocialPreviews` gallery to inspect:
- Friends list states (Empty, Many).
- Incoming and Outgoing request lists.
- Public profile actions for different relationship states.

## Testing

- **Domain Tests**: `test/features/social/social_domain_test.dart`
- **Security Tests**: (In progress) Verifying cross-user access restrictions.
- **UI Tests**: (In progress) Golden tests for social components.
