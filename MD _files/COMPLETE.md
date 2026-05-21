# Stock Simulator App - Project Action Plan

## 1. Project Goal

Build a Flutter-based stock simulator app where users can:

* explore stocks
* view prices and charts
* buy/sell with virtual money
* track portfolio performance
* manage watchlist
* view history, analytics, alerts, and leaderboard

---

# 2. Project Phases

## Phase 1 - Planning

### Tasks

* finalize app name
* finalize app theme and UI style
* freeze feature list for MVP
* decide whether you will use:

  * mock stock data first
  * or real market API
* finalize folder architecture
* finalize dependencies
* prepare wireframe for all main screens

### Output

* project structure ready
* feature scope ready
* screen list ready

---

## Phase 2 - Project Setup

### Tasks

* create Flutter project
* add dependencies in `pubspec.yaml`
* create folder architecture
* set up:

  * Riverpod
  * go_router
  * Dio
  * Firebase Core
  * Firebase Auth
  * Cloud Firestore
  * Firebase Messaging
  * shared preferences / secure local storage where needed
* create common theme files
* add assets folders
* create reusable widgets base
* connect Firebase config files and initialize Firebase in `main.dart`

### Output

* app boots successfully
* clean architecture ready
* routing and theming ready
* Firebase setup ready

---

## Phase 3 - Core Foundation

### Tasks

* create global constants
* create app router
* create storage services
* create Firebase service wrappers
* create mock data models
* create base repository interfaces
* create repository implementations
* create utility files:

  * formatters
  * validators
  * result/error handling
* create common UI widgets:

  * app button
  * loader
  * error state
  * empty state
  * cards/chips

### Output

* reusable foundation ready
* clean code base ready for features

---

## Phase 4 - Authentication & Onboarding

### Tasks

* build splash screen
* build onboarding screen
* build login screen
* build register screen
* build guest mode logic
* connect Firebase Auth:

  * email/password
  * phone OTP if needed
* create Firestore user profile on signup
* persist auth/session locally only where needed for app state

### Output

* user can enter app
* onboarding flow complete

---

## Phase 5 - Home Dashboard

### Tasks

* create dashboard layout
* show:

  * virtual balance
  * portfolio value
  * daily profit/loss
  * top movers
  * recent transactions
* add quick action buttons
* connect mock or live data

### Output

* main landing screen complete

---

## Phase 6 - Market Module

### Tasks

* build market page
* add search bar
* add tabs:

  * top gainers
  * top losers
  * trending
  * most active
* build stock list item widget
* build stock details page
* show:

  * stock name
  * symbol
  * current price
  * change %
  * chart
  * stats
  * buy/sell buttons

### Output

* stock browsing and stock detail flow complete

---

## Phase 7 - Trading System

### Tasks

* create simulator engine logic
* implement buy stock logic
* implement sell stock logic
* create bottom sheet or order screen
* validate:

  * sufficient balance
  * sufficient shares
* update holdings after trade
* recalculate average buy price
* save transaction history in Firestore
* update portfolio summary in Firestore
* show trade confirmation
* show success/failure messages

### Output

* core stock simulator fully working

---

## Phase 8 - Portfolio Module

### Tasks

* build portfolio page
* show:

  * total invested
  * current value
  * unrealized P/L
  * return %
* build holdings list
* build holding detail page
* calculate current value from latest prices
* build transaction history page
* filter by buy/sell/all

### Output

* portfolio tracking complete

---

## Phase 9 - Watchlist Module

### Tasks

* build watchlist page
* add/remove stock from watchlist
* persist watchlist in Firestore
* cache watchlist locally only if needed
* show watchlist stock list
* allow quick navigation to stock details
* show empty watchlist state

### Output

* watchlist complete

---

## Phase 10 - Settings Module

### Tasks

* build settings page
* add:

  * dark/light mode
  * currency selector
  * reset portfolio
  * app info
  * simulation settings
* create reset confirmation dialog
* allow user to reset simulation

### Output

* settings and app control ready

---

## Phase 11 - Analytics Module

### Tasks

* build portfolio analytics screen
* add charts:

  * allocation chart
  * performance chart
  * realized vs unrealized P/L
* build risk analysis screen
* calculate:

  * best performer
  * worst performer
  * diversification
  * profit timeline

### Output

* app feels more advanced and realistic

---

## Phase 12 - Alerts & Notifications

### Tasks

* build alert creation page
* allow price alert setup
* save alerts in Firestore
* create notifications screen
* trigger notification when condition matches
* add alert history page
* use Firebase Messaging for push support if needed

### Output

* app becomes more interactive

---

## Phase 13 - News Module

### Tasks

* build news page
* build news detail page
* show stock-related news
* connect stock details to related news
* add daily market summary page

### Output

* more real-market feel

---

## Phase 14 - Social / Gamification

### Tasks

* build leaderboard page
* build achievements page
* build profile page
* add badges
* add challenge mode
* add daily missions
* add streak logic
* store leaderboard/profile progress with Firestore where needed

### Output

* higher engagement and better project impression

---

## Phase 15 - Advanced Trading Features

### Tasks

* implement limit orders
* implement stop-loss orders
* build open orders page
* build order book page
* add order preview
* support partial selling
* optionally add market open/close logic

### Output

* simulator starts feeling close to a real trading platform

---

## Phase 16 - Real API Integration

### Tasks

* choose stock market API
* connect market data into the Flutter + Firebase app flow
* map API response to models
* handle loading/error/empty states
* cache selected data locally or in Firestore where useful
* optimize refresh flow
* keep Firebase as the main backend for auth and user data

### Output

* live or near-live market data support

---

## Phase 17 - Optional Backend / ML Integration

### Tasks

* decide if Django is needed for:

  * custom business APIs
  * market data aggregation
  * admin tools
* decide if ML is needed for:

  * prediction
  * recommendation
  * analytics insights
* connect optional backend services without replacing Firebase auth/data flow

### Output

* advanced backend features added only if needed

---

## Phase 18. Testing

### Tasks

* test all navigation flows
* test Firebase initialization
* test login/register/auth state
* test buy/sell logic
* test average price calculation
* test portfolio value updates
* test watchlist persistence
* test settings persistence
* test error cases:

  * no internet
  * invalid input
  * zero quantity
  * insufficient funds
  * insufficient holdings

### Output

* stable app

---

## Phase 19 - UI Polish

### Tasks

* improve padding, spacing, text hierarchy
* add shimmer loading
* add pull to refresh
* add snackbars/toasts
* add animations:

  * success animation
  * page transitions
  * number updates
* improve dark mode
* refine chart visuals

### Output

* polished final app

---

## Phase 20 - Final Documentation

### Tasks

* write project abstract
* write objective
* write feature list
* write architecture explanation
* write modules explanation
* write simulator logic explanation
* add screenshots
* make PPT/report if needed

### Output

* college/project submission ready

---

# 3. MVP Build Order

Follow this order strictly:

## Step 1

* project setup
* architecture
* router
* theme
* reusable widgets
* Firebase setup

## Step 2

* splash
* onboarding
* login/register/guest

## Step 3

* home dashboard

## Step 4

* market page
* stock details

## Step 5

* buy/sell simulator logic

## Step 6

* portfolio
* holdings
* transaction history

## Step 7

* watchlist

## Step 8

* settings
* reset simulation

## Step 9

* analytics
* charts

## Step 10

* alerts
* notifications
* leaderboard
* challenges
* news

---

# 4. Detailed Weekly Plan

## Week 1 - Setup & Architecture

* create Flutter project
* add dependencies
* create folder architecture
* set up theme
* set up routing
* connect Firebase
* make reusable base widgets

## Week 2 - Auth & Navigation

* splash
* onboarding
* login/register
* guest entry
* Firebase Auth setup
* bottom navigation shell

## Week 3 - Market Module

* market page
* search page
* stock details page
* stock card/tile widgets
* chart placeholder

## Week 4 - Trading Logic

* buy flow
* sell flow
* validation
* transaction storage in Firestore
* portfolio update logic

## Week 5 - Portfolio & Watchlist

* portfolio screen
* holdings
* transaction history
* watchlist add/remove
* Firestore persistence

## Week 6 - Settings & Reset

* settings page
* simulator settings
* reset simulation
* user preferences

## Week 7 - Advanced Features

* analytics
* alerts
* notifications
* leaderboard
* achievements/challenges

## Week 8 - Final Polish

* bug fixing
* UI polish
* loading/error states
* animations
* screenshots
* project report/presentation

---

# 5. Module Checklist

## A. Setup

* [ ] Flutter project created
* [ ] dependencies added
* [ ] assets folder created
* [ ] theme created
* [ ] router created
* [ ] Firebase connected

## B. Core

* [ ] constants
* [ ] utilities
* [ ] storage service
* [ ] Firebase service
* [ ] network service
* [ ] common widgets

## C. Auth

* [ ] splash
* [ ] onboarding
* [ ] login
* [ ] register
* [ ] guest mode
* [ ] Firebase Auth connected
* [ ] Firestore user profile created

## D. Home

* [ ] balance card
* [ ] portfolio summary
* [ ] recent transactions
* [ ] top movers

## E. Market

* [ ] stock list
* [ ] search
* [ ] stock details
* [ ] stock chart
* [ ] market tabs

## F. Trading

* [ ] buy stock
* [ ] sell stock
* [ ] order preview
* [ ] trade confirmation
* [ ] simulator validations

## G. Portfolio

* [ ] holdings list
* [ ] holding details
* [ ] transaction history
* [ ] P/L calculation
* [ ] Firestore persistence

## H. Watchlist

* [ ] add stock
* [ ] remove stock
* [ ] empty state
* [ ] persistence

## I. Settings

* [ ] theme switch
* [ ] currency selection
* [ ] reset portfolio
* [ ] app info

## J. Advanced

* [ ] alerts
* [ ] notifications
* [ ] analytics
* [ ] leaderboard
* [ ] challenges
* [ ] news
* [ ] optional backend/ML integration

---

# 6. Trade Logic Tasks

## Buy Stock

* [ ] fetch current price
* [ ] input quantity
* [ ] calculate total cost
* [ ] compare with balance
* [ ] create transaction
* [ ] update holding
* [ ] reduce cash
* [ ] show success

## Sell Stock

* [ ] verify holding exists
* [ ] verify enough quantity
* [ ] calculate sell value
* [ ] create transaction
* [ ] update/remove holding
* [ ] increase cash
* [ ] show success

## Portfolio Calculation

* [ ] invested value
* [ ] current value
* [ ] holding P/L
* [ ] total P/L
* [ ] total return %
* [ ] realized/unrealized split

---

# 7. UI/UX Tasks

## Must have

* [ ] clean home dashboard
* [ ] easy buy/sell flow
* [ ] quick search
* [ ] responsive portfolio cards
* [ ] nice empty states
* [ ] loading states
* [ ] error states

## Good to have

* [ ] animated number changes
* [ ] shimmer loaders
* [ ] success bottom sheet
* [ ] pull to refresh
* [ ] dark mode
* [ ] chart transitions

---

# 8. Technical Tasks

## State Management

* [ ] Riverpod providers for each module
* [ ] async loading/error handling
* [ ] local state updates after trades

## Data

* [ ] models
* [ ] DTO parsing
* [ ] repository implementations
* [ ] Firestore persistence

## Routing

* [ ] auth routes
* [ ] shell routes
* [ ] nested detail routes
* [ ] protected routes if needed

---

# 9. Final Submission Tasks

* [ ] app logo
* [ ] splash branding
* [ ] screenshots of all major screens
* [ ] source code cleaned
* [ ] comments added where needed
* [ ] README written
* [ ] PPT/report prepared
* [ ] demo flow rehearsed

---

# 10. Best Development Sequence

Build in this exact sequence:

```text
Setup
-> Architecture
-> Theme + Router
-> Firebase Setup
-> Splash + Onboarding
-> Auth / Guest
-> Home
-> Market
-> Stock Details
-> Buy/Sell Logic
-> Portfolio
-> Watchlist
-> Settings
-> Analytics
-> Alerts
-> News
-> Leaderboard / Challenges
-> Real API Integration
-> Optional Backend / ML
-> Testing
-> Polish
-> Documentation
```

---

# 11. Final Goal Version

## Minimum Viable Product

* splash
* onboarding
* auth or guest mode
* home
* market
* stock details
* buy/sell
* portfolio
* watchlist
* transaction history
* settings/reset

## Strong Final Version

* everything in MVP
* analytics
* alerts
* notifications
* leaderboard
* achievements
* challenge mode
* stock news
* real API integration
* optional backend or ML enhancements
* polished charts and animations

---

# 12. What you should do right now

Your immediate next tasks should be:

1. finish project setup, Firebase setup, and folder structure
2. make router and theme
3. build bottom navigation shell
4. complete home, market, and stock details screens
5. implement buy/sell simulator logic with Firestore persistence
6. connect portfolio and watchlist
7. then move to analytics and advanced features
