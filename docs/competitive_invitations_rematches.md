# Competitive Invitations & Rematches

## Overview
This system streamlines the transition from player discovery to competitive action. It provides a polished, low-friction layer for challenging friends, rematching rivals, and managing invitations.

## Quick Action Framework
The `CompetitiveQuickActions` component dynamically determines available actions based on:
- **Presence**: Is the player online/available?
- **Match State**: Are they already in a match?
- **Relationship**: Are they friends/blocked?
- **Recency**: Is this a recent opponent eligible for a rematch?
- **Pending State**: Is there an incoming/outgoing invitation?

## Invitation Lifecycle
Reuses the existing `CompetitiveChallenge` lifecycle:
- **PENDING**: Sender has sent the invitation.
- **ACCEPTED**: Receiver accepted; triggers immediate matchmaking/match creation.
- **DECLINED**: Receiver declined.
- **CANCELLED**: Sender withdrew the invitation.
- **EXPIRED**: Time limit reached (default 1 hour).

## Rematch Logic
A "Rematch" is a specialized quick challenge against a recent opponent.
- **Discovery**: Found in the `RecentOpponentsSection` or immediately after a match result.
- **Eligibility**: Authorized via completed match history records.

## UI Components

### `RecentOpponentsSection`
Horizontal quick-scroll section for the dashboard or versus lobby.

### `RecentOpponentCard`
Unified player profile row with a high-priority `REMATCH` button.

### `IncomingChallengeCard` & `OutgoingChallengeCard`
Polished cards for the challenge center with integrated presence indicators.

### `CompetitiveQuickActions`
Context-aware button group for profiles and lists.

## Security & Anti-Abuse
- **Server Validated**: All match creation and invitation acceptances are verified on the backend.
- **Blocked Users**: Automatically hidden and restricted from all competitive interactions.
- **Spam Prevention**: Rate limits on invitation creation and cancellation.
