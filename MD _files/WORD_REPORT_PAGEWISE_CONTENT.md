# Stock Simulator India

Expanded original report draft for Word formatting.

This version is intentionally written with much denser academic content so that the main report chapters can be formatted to at least one full page each in Word. The sample PDF may be used only for layout inspiration, not for direct copying.

Formatting guidance for the final Word report:

- use `Times New Roman`, font size `12`, line spacing `1.5`
- apply page breaks after each page marker if you want strict page-wise formatting
- add screenshots, diagrams, tables, and API snippets on the indicated pages
- use Word heading styles for automatic table of contents generation

---

## Page 1. Title Page

**Stock Simulator India**

A Major Project Report submitted in partial fulfillment of the requirements for the award of the degree in the relevant academic program.

Submitted by:

- Name: [Your Name]
- Roll Number: [Your Roll Number]
- Enrollment Number: [Your Enrollment Number]
- Department: [Your Department]
- College: [Your College Name]
- University: [Your University Name]
- Session: 2025-2026

Under the guidance of:

- Guide Name: [Guide Name]
- Designation: [Guide Designation]

This project presents the design, implementation, and documentation of a full-stack stock market simulation system intended for educational use. The application allows users to experience stock exploration, virtual trading, portfolio analysis, watchlist management, comparative ranking, and machine learning supported insights through one integrated platform built using Flutter, Django, Firebase, and Python-based ML tooling.

## Page 2. Certificate

This is to certify that the project report entitled **Stock Simulator India** submitted by **[Your Name]** is a bonafide record of the work carried out under my supervision during the academic session 2025-2026 in partial fulfillment of the requirements for the award of the degree prescribed by the institution.

To the best of my knowledge, the work embodied in this report is original and has been completed by the student with sincere effort, regular consultation, and appropriate technical understanding. The project demonstrates the application of software engineering concepts including frontend development, backend API design, data modeling, authentication integration, and machine learning support.

The candidate has shown satisfactory competence in problem identification, system analysis, modular implementation, validation, and technical documentation. The project is suitable for submission and academic evaluation.

Signature of Guide: ____________________

Name of Guide: ____________________

Department: ____________________

Date: ____________________

## Page 3. Declaration

I hereby declare that the work presented in the project report entitled **Stock Simulator India** is my own original work carried out under the guidance of the faculty supervisor. The report has been prepared for academic submission and is based on the actual design and implementation of the project completed during the present academic session.

I further declare that this report has not been submitted previously, in whole or in part, for the award of any degree, diploma, or certificate in this or any other institution. Wherever external documentation, framework references, conceptual ideas, or technical resources have been used, appropriate acknowledgment has been made in the references section.

I also state that this project is intended for educational and simulation purposes only. It does not perform real-money stock trading and should not be interpreted as a commercial financial platform. The buying and selling processes described in this report operate on virtual balance and simulated data flow for learning-oriented use.

Signature of Student: ____________________

Name: ____________________

Date: ____________________

## Page 4. Acknowledgement

I would like to express my sincere gratitude to my project guide for continuous support, valuable suggestions, and technical guidance during the development of this project. Their encouragement helped me understand the problem more clearly and improve both the implementation and the documentation of the work. The guidance received during each stage, from planning to development and report writing, played an important role in the successful completion of this project.

I am also thankful to the faculty members of my department for providing an academic environment that encouraged practical learning and experimentation. Their inputs on software engineering principles, architecture planning, and presentation quality helped in shaping this project into a more structured and meaningful system.

I would like to thank my friends and classmates for their ideas, feedback, and moral support throughout the project duration. Discussions with peers helped in identifying usability issues, improving feature flow, and refining the application structure. Their support made the development journey smoother and more motivating.

Finally, I express heartfelt gratitude to my family for their patience, understanding, and constant encouragement. Their faith and support gave me the confidence to complete this work with dedication and care.

## Page 5. Abstract

Stock Simulator India is a full-stack educational platform developed to help users understand stock market operations in a safe and controlled environment. The main objective of the project is to provide a paper trading system in which users can explore stock data, simulate buy and sell operations, monitor portfolio performance, maintain a personalized watchlist, and compare performance using a leaderboard. Since the application is based on virtual trading rather than real financial transactions, it offers a practical learning environment for students, beginners, and users who wish to develop confidence before entering actual stock markets.

The frontend of the application is built using Flutter, which supports a responsive and structured user interface across multiple platforms. The backend is developed using Django and Django REST Framework, which are used to expose APIs, manage business rules, and maintain simulator data. Firebase is integrated for authentication-oriented support in the app layer, while a separate machine learning workspace built in Python provides prediction and recommendation-related analytical features. The backend is organized into modules such as users, market, portfolio, watchlist, leaderboard, and ml_api, creating a modular and maintainable architecture.

The project is academically significant because it combines multiple important software engineering domains in one implementation. It includes mobile and web interface development, backend service design, relational data management, authentication integration, API communication, simulation logic, and ML-assisted insights. It is practically significant because it solves a meaningful real-world problem: the lack of a safe environment in which beginners can practice stock trading concepts without risking money.

The project therefore functions as both an educational tool for end users and a strong case study of applied full-stack development. It demonstrates how modern technologies can be combined to build an interactive, scalable, and analytically enriched learning platform.

## Page 6. Table of Contents

Suggested table of contents for the final Word report:

1. Introduction
2. Background and Need of the Project
3. Problem Statement
4. Objectives of the Project
5. Scope of the Project
6. Feasibility Study
7. Literature Review
8. Existing System and Gap Analysis
9. Proposed System
10. Technology Stack
11. System Architecture
12. Module Description
13. Workflow and Data Flow
14. Database Design
15. API Design
16. Algorithms and Business Logic
17. Implementation Details
18. Testing and Validation
19. Advantages and Limitations
20. Future Scope
21. Conclusion
22. References
23. Appendix

In the final Word document, apply heading styles to all chapter titles and generate this page automatically using the Word references tool. This will create a cleaner and more professional academic layout.

## Page 7. List of Figures and List of Tables

The final report should include a dedicated list of figures and a list of tables after the table of contents. Suggested figures include system architecture diagram, frontend architecture diagram, backend module diagram, authentication flow diagram, portfolio workflow diagram, ER diagram, API interaction diagram, and machine learning pipeline diagram. Screenshots of the login page, register page, home dashboard, market page, stock details page, portfolio page, watchlist page, leaderboard page, and ML status output should also be listed as figures if they are inserted in the document.

Suggested tables include technology stack summary, feature list, module-wise responsibilities, database field summary, API endpoint summary, test case table, requirement specification table, and future enhancement roadmap. Including these lists improves academic presentation and helps examiners locate important content quickly.

This page may remain partially blank in the draft stage, but in the final Word version it should be updated after all visuals and tables have been inserted and captioned properly.

## Page 8. Introduction

In the present digital era, software systems have transformed the way people access knowledge, practice skills, and interact with financial information. One of the most visible examples of this transformation is the increasing use of digital platforms for stock market observation and trading. Mobile applications, web dashboards, and financial portals have made market-related information widely accessible. However, although access to information has improved, practical understanding of trading mechanisms remains difficult for beginners. The real stock market is fast-moving, uncertain, and emotionally demanding. New users may know the basic terms related to trading, but they often struggle when it comes to practical actions such as selecting a stock, understanding price movement, placing an order, and evaluating the effect of their decisions on overall portfolio performance.

For most beginners, the biggest challenge is risk. Learning through direct market participation can be costly because mistakes in real trading lead to actual financial losses. This discourages experimentation and makes the learning process stressful. A beginner may hesitate to place even a small order because of uncertainty, fear of loss, or limited understanding of market behavior. As a result, interest in the stock market often remains theoretical rather than practical. This creates a need for an educational environment where users can interact with stock trading workflows safely, repeatedly, and without real monetary exposure.

Stock Simulator India is developed to address this exact problem. It is designed as a paper trading platform in which users can register, log in, explore stock information, inspect price trends, simulate buying and selling, maintain a watchlist, observe portfolio changes, and compare their results through a leaderboard. Since all actions are performed using virtual funds, the application helps users learn by doing rather than merely reading or watching educational content. The project aims to reduce fear, improve confidence, and create a practical bridge between financial curiosity and real understanding.

Another important aspect of the project is its technical scope. The system is not limited to a static user interface. Instead, it combines frontend design, backend logic, authentication support, structured APIs, data models, and machine learning integration. The frontend is developed using Flutter. The backend is developed using Django and Django REST Framework. Firebase supports authentication-related processes, while the machine learning layer provides prediction and recommendation style insight support. Together, these technologies form a complete full-stack solution.

Thus, the introduction to this project is not only about stock market education; it is also about solving an educational problem through the deliberate integration of modern software technologies. The project stands at the intersection of financial literacy and software engineering, making it relevant both academically and practically.

## Page 9. Background and Need of the Project

Financial literacy has gained enormous importance in recent years. As more people seek to understand saving, investing, and wealth creation, the stock market has emerged as one of the most discussed areas of personal finance. Social media, financial videos, blogs, and news channels have made terms like equity, portfolio, returns, market trend, and investment strategy familiar even to people who have never traded before. This growing awareness has created a new class of users: curious beginners who want to learn market behavior but are not yet ready for real financial participation.

The availability of online brokerage apps and digital investment services has made real market entry easier than ever before. However, easy access does not automatically translate into informed decision-making. Many users register on trading platforms without fully understanding price volatility, risk exposure, position sizing, emotional bias, or portfolio balance. The result is that beginner participation sometimes happens before beginner understanding. This mismatch can produce losses, frustration, and negative perceptions of market investing.

Traditional educational methods are useful but incomplete in this context. Reading about the stock market helps users understand terminology, but it does not fully teach them how decisions play out in practice. Watching a tutorial may explain what a watchlist or a portfolio is, but it does not reproduce the experience of selecting a stock, deciding whether to buy, monitoring price movement, and evaluating whether the decision was effective. Practical understanding requires an environment in which actions can be taken and outcomes can be observed safely.

This is where a stock simulator becomes necessary. A simulator removes the financial risk while preserving the structure of market interaction. It allows a user to make decisions, observe consequences, and learn through repetition. The learner is free to experiment with buying and selling without the fear of losing real money. This reduces emotional pressure and creates a better educational environment.

The need for this project is also strong from an academic perspective. Educational institutions increasingly encourage students to build projects that solve relevant real-world problems. A stock market simulator is meaningful because it connects software engineering with financial education. It allows a student developer to demonstrate interface design, backend development, cloud integration, database design, API creation, and machine learning support within one cohesive project. For these reasons, the need for Stock Simulator India is both user-centered and academically justified.

## Page 10. Problem Statement

Beginners, students, and first-time investors often want to understand the stock market, but they lack access to a safe and practical environment where they can perform trading-related activities without financial risk. Real trading platforms are designed for actual investment and therefore expose users to real gains and losses. This makes them unsuitable as first learning environments for many users who need guided practice before entering a live market setting.

The problem is not simply a lack of information. In fact, information about the stock market is widely available through websites, videos, articles, and financial applications. The deeper problem is the lack of structured, hands-on experience. A learner may understand what a portfolio means in theory, but still not know how buying a stock affects cash balance, how average purchase price is maintained, how profit or loss is interpreted, or how multiple decisions together shape portfolio performance over time.

Another aspect of the problem is fragmentation. Existing educational resources often focus on only one part of the experience. Some provide stock prices, some provide charts, some provide articles, and some provide mock questions. Very few systems bring together user identity, stock exploration, watchlist management, paper trading, transaction history, portfolio analysis, and analytical insights in a single educational platform. This fragmented learning model slows understanding and reduces practical engagement.

The problem therefore can be stated as follows: there is a need for an integrated stock market simulation system that allows users to learn market behavior and trading workflows through virtual interaction rather than real-money exposure. Such a system should be user-friendly, modular, educationally meaningful, and technically structured enough to support future enhancement.

Stock Simulator India is proposed as a solution to this problem. It creates a risk-free environment in which users can learn by exploring, trading virtually, observing outcomes, and comparing performance. The problem statement is thus directly tied to the central purpose of the project: to bridge the gap between theoretical market awareness and practical stock trading understanding.

## Page 11. Objectives of the Project

The primary objective of Stock Simulator India is to design and develop a paper trading platform that helps users understand stock market operations without using real money. The application should provide a practical learning environment in which users can explore stocks, make simulated investment decisions, and observe the results of those decisions through an interactive portfolio.

One of the major objectives is to build a clean and beginner-friendly interface. Since the application is intended for educational use, the screens must be structured in a way that helps users move smoothly from login to market exploration, stock analysis, simulated trade placement, portfolio observation, and settings. A complicated interface would reduce the educational value of the project, so simplicity and navigation clarity are important design goals.

Another objective is to implement a backend system capable of handling essential simulator logic. This includes managing stock records, chart data, holdings, transactions, watchlist items, leaderboard entries, and prediction snapshots. The backend should expose APIs in a modular manner so that the frontend can interact with the system consistently and additional features can be added later.

The project also aims to integrate user identity handling through Firebase-supported authentication flow and backend-side user synchronization. This objective is important because personalized trading simulation requires user-specific balances, holdings, watchlists, and rankings. Without a user identity layer, the simulator would not be able to provide individualized learning experiences.

An additional objective is to enrich the platform through machine learning integration. The project includes an analytical layer that supports prediction and recommendation endpoints. Even though the current ML implementation is baseline-level, the objective is to demonstrate how an intelligent support system can be connected to a stock simulation platform.

Finally, the project aims to serve as a comprehensive academic case study. It is not only meant to function as an app for users but also to represent a serious full-stack engineering effort involving frontend design, backend logic, cloud-linked authentication, data handling, and ML-assisted features. This makes the project valuable as both a product and a learning demonstration.

## Page 12. Scope of the Project

The scope of Stock Simulator India is centered on creating a learning-focused stock market simulator that enables users to understand market workflows through virtual practice. The project covers the features required for a user to move through a realistic trading learning cycle, beginning with account access and continuing through market exploration, stock analysis, trading simulation, portfolio monitoring, and performance comparison.

From the application perspective, the scope includes the implementation of screens and user flows such as splash, login, registration, home dashboard, market page, stock details page, buy and sell interaction, portfolio view, transaction history, watchlist, leaderboard, profile, settings, and support-oriented sections. These screens together create a usable and structured application rather than a disconnected set of pages.

From the backend perspective, the scope includes the design of modular Django apps for users, market, portfolio, watchlist, leaderboard, and ML integration. These apps manage business logic, expose REST-style endpoints, store simulator data, and support development-stage seeding behavior when live data is unavailable. The backend also includes data models for stock records, candles, user profiles, holdings, transactions, watchlist items, leaderboard entries, and prediction snapshots.

The scope also extends to the machine learning workspace, where datasets, scripts, trained model artifacts, and metadata are maintained. This component is used to support prediction and recommendation endpoints exposed through the Django backend. Its role is to enhance the simulator with analytical depth rather than to become the sole source of decision-making.

However, the scope is intentionally limited in some areas. The project does not execute real-market orders, process actual money, or serve as a commercial trading system. It is not designed for brokerage integration, live exchange compliance, or regulated financial deployment. These limitations are deliberate because the current goal is simulation, education, and technical demonstration. By clearly defining scope boundaries, the project remains manageable, focused, and academically suitable.

## Page 13. Feasibility Study

Any meaningful software project must be evaluated for feasibility before it is considered practical. For Stock Simulator India, feasibility can be examined from technical, economic, operational, and academic perspectives. A project may be interesting in theory, but if it cannot be implemented within available tools, skills, and time, it becomes unsuitable for student development. Fortunately, this project demonstrates good feasibility across all major dimensions.

From the technical point of view, the chosen technology stack is highly feasible. Flutter is well suited for building modern cross-platform interfaces and has a rich ecosystem for state management, navigation, and networking. Django and Django REST Framework provide a mature and structured environment for backend API creation, data modeling, and business logic. Firebase supports practical authentication flows, while Python-based libraries such as pandas, scikit-learn, and joblib make basic machine learning integration achievable. Since all of these technologies are widely documented and developer-friendly, the technical implementation is realistic within an academic project cycle.

Economic feasibility is also favorable. The project can be developed primarily with open-source tools and development-friendly services. Flutter, Django, Python, and most required libraries are freely available. SQLite is sufficient for local development, which removes the immediate need for paid database infrastructure. Firebase provides a developer-friendly starting point for authentication support. As a result, the cost of implementing the project is relatively low, especially for a student environment.

Operational feasibility is strong because the application solves a real user need in a practical way. The idea of paper trading is easy to understand, and the intended users, such as students or beginners, can benefit from it directly. The system also remains manageable in operation because it does not involve real financial transactions, legal brokerage complexity, or high-frequency live data infrastructure. This makes it suitable for controlled educational use.

Academic feasibility is perhaps the strongest aspect. The project includes multiple significant areas of computer science and software engineering: UI development, backend design, authentication integration, API interaction, data modeling, and machine learning support. It is therefore rich enough to qualify as a major academic project while still remaining bounded enough to be implemented and documented successfully. For all these reasons, the project is considered feasible and appropriate for student-level full-stack development.

## Page 14. Literature Review

The literature and technical background for this project emerge from two major areas: financial learning systems and modern full-stack software development. Educational stock market applications, paper trading platforms, and investment training systems have long been recognized as useful tools for helping users understand trading behavior without real monetary exposure. The core idea common to such platforms is that experiential learning often produces better practical understanding than passive reading or observation alone. When learners can perform actions in a controlled environment, they are more likely to understand concepts such as order placement, risk, portfolio composition, and market movement.

At the same time, the technical literature around modern application development emphasizes modularity, layered architecture, and separation of responsibilities. Framework documentation and best-practice guidance for Flutter, Django, Django REST Framework, and Firebase all stress the importance of clear structure, reusable components, and scalable system design. In this project, those principles are visible in the feature-first Flutter structure, modular Django apps, API-oriented communication, and the separate ML workspace used for experimentation and inference support.

Another relevant area of literature is the use of machine learning in financial applications. While production-grade financial prediction is complex and requires significant rigor, academic and experimental systems often use baseline models to demonstrate predictive workflows, feature engineering, and inference APIs. The purpose is not necessarily to create guaranteed trading advice, but to show how analytics can be embedded within broader platforms. This concept directly influences the design of the ml_api module in the present project.

The literature review also suggests that many beginner-oriented financial learning tools fail because they isolate theory from action. Some provide only articles. Others offer market information without personalized simulation. Some provide gamified investment ideas but lack the architecture needed for real educational continuity. Stock Simulator India attempts to contribute in this context by bringing together interface, data, simulation, and analytical support in one integrated environment. The review therefore justifies both the educational purpose and the technical direction of the project.

## Page 15. Existing System and Gap Analysis

Before proposing a new system, it is important to understand the limitations of existing approaches. In the current learning environment, a beginner who wants to understand stock trading typically depends on one or more of the following: video tutorials, blog articles, financial news portals, charting tools, or real trading applications. Each of these resources is useful in its own way, but none of them completely satisfies the need for a structured learning simulator.

Video tutorials and articles are useful for introducing concepts, but they do not create interaction. A learner may understand that buying low and selling high is desirable, yet still not know how to observe the effect of a buy action on virtual cash, holdings, and overall portfolio value. Real trading apps provide the action layer, but they are tied to actual money and therefore create risk for beginners. Charting tools provide price visualization but do not necessarily connect that information to user-specific educational workflows such as portfolio simulation, watchlists, and transaction review.

The main gap, therefore, is the absence of an integrated beginner-oriented learning environment that combines stock exploration, paper trading, watchlist management, transaction history, portfolio observation, and analytical support within one system. A second gap is technical in nature: many educational prototypes focus only on interface design or only on backend logic, but they do not connect both layers meaningfully. A third gap is analytical enrichment. Even where simulation exists, simple insight features such as prediction or recommendation support are often missing.

Stock Simulator India addresses these gaps by providing one connected application with a usable UI, a structured backend, user-specific simulator behavior, and a machine learning extension layer. The gap analysis thus validates the need for a new system and helps explain why this project takes the form it does.

## Page 16. Proposed System

The proposed system is a full-stack educational paper trading platform named Stock Simulator India. The system is designed to simulate stock market interaction in a way that is understandable to beginners and technically structured for academic demonstration. Users of the system can create an account, access the dashboard, view available stocks, inspect details and chart data, simulate buy and sell operations, observe their portfolio, track chosen stocks using a watchlist, and compare performance through leaderboard rankings.

The system is proposed as a layered architecture. Flutter acts as the presentation layer and provides all screens, navigation, and interactive widgets. Firebase supports app-side authentication flow and identity-related handling. Django and Django REST Framework implement the backend logic, data models, and APIs. The machine learning workspace trains and stores baseline models whose outputs can be exposed through the backend using prediction and recommendation endpoints.

The strength of the proposed system lies in its modularity. Each major concern is handled by an appropriate layer. The frontend is focused on usability and user experience. The backend is focused on business logic and structured data access. Firebase reduces complexity for identity management. The machine learning workspace remains separate from the transactional application core, which is an important design choice because it allows experimentation without destabilizing the main application.

The proposed system is not intended to replace real trading platforms. Its purpose is different. It exists to provide a safe learning environment and to demonstrate how such an environment can be built using modern development tools. This makes the proposed system educationally useful, technically valid, and well matched to the identified problem.

## Page 17. Technology Stack

The selection of an appropriate technology stack is critical in full-stack project development because each technology must contribute to the overall goals of usability, maintainability, and system integration. In Stock Simulator India, the chosen stack reflects the need for a responsive frontend, a structured backend, flexible authentication support, and analytical extension through machine learning.

The frontend of the project is built using Flutter. Flutter is a modern UI toolkit that supports cross-platform development from a single codebase. It is particularly useful in this project because it enables the creation of a visually consistent user interface while also allowing the application to be tested on web and other platforms. Additional packages such as Riverpod, go_router, and Dio are used for state management, navigation, and network communication. These packages help keep the frontend organized and reduce the complexity of data flow across screens.

The backend is developed using Django and Django REST Framework. Django offers a structured, mature, and secure environment for handling server-side logic, while Django REST Framework simplifies API development and response serialization. The backend uses SQLite for development storage, which is appropriate for an academic project because it is simple to configure and sufficient for local simulation data.

Firebase is integrated to support authentication and profile-related app workflows. The Flutter codebase includes Firebase core, Firebase authentication, Firestore, and messaging support, showing that the project is designed with real app service integration in mind. This improves the practical relevance of the application and helps model how modern mobile apps often handle identity.

The machine learning layer is implemented using Python libraries such as pandas, scikit-learn, and joblib. This layer is responsible for data preparation, baseline model training, artifact storage, and backend-facing inference support. Together, these technologies create a balanced stack suitable for both educational impact and full-stack demonstration.

## Page 18. System Architecture Overview

The architecture of Stock Simulator India follows a modular layered model in which each major system responsibility is assigned to a separate component. This architectural style is beneficial because it reduces unnecessary coupling, improves maintainability, and makes the overall system easier to understand and explain. For an academic project, clear architecture is especially valuable because it shows deliberate engineering rather than random feature accumulation.

At the top layer is the Flutter frontend. This layer is responsible for everything the user sees and interacts with, including authentication pages, dashboard elements, stock lists, charts, trading screens, portfolio summaries, and settings. The frontend manages presentation logic, navigation, and communication with backend services.

The second layer is the Firebase-based identity support layer. When the user registers or logs in, Firebase Authentication provides a convenient way to manage credentials and identity at the app level. Firestore-related support can be used for profile-linked or supplementary data. This layer is particularly useful because it separates authentication concerns from the rest of the application workflow.

The third layer is the Django backend. This is the core application logic layer, where all simulator-specific processing occurs. The backend stores and manages stock records, holdings, transactions, watchlist items, leaderboard entries, and ML snapshots. It exposes APIs that the Flutter application consumes through structured requests.

The fourth layer is the machine learning workspace. This layer is not directly visible to the user, but it adds analytical value by supporting prediction and recommendation endpoints. The backend interacts with this layer by loading model artifacts and serving inference results. This architecture therefore creates a clear distinction between presentation, identity, business logic, and analytics, while still connecting all parts into one system.

## Page 19. Frontend Architecture

The Flutter frontend is designed using a structured, feature-first approach with clear separation between app-wide concerns and feature-specific logic. This architecture is a strong point of the project because it reflects planning and maintainability rather than ad hoc screen development. The codebase contains dedicated folders for `app`, `core`, `data`, `domain`, `features`, and `shared`, indicating that the project follows a clean and scalable organization.

The `app` layer contains routing, theme definitions, and constants. This is where global configurations such as route names, navigation behavior, color themes, and storage keys are maintained. The `core` layer contains reusable services, network clients, providers, utilities, and widgets. Services such as local storage, secure storage, Firebase support, Firestore support, market clock handling, and notifications all reside in this layer, which helps centralize infrastructure-level functionality.

The `data` layer includes local and remote data sources, models, and repository implementations. This is the point at which API responses, local caches, and serialized objects are handled. The `domain` layer contains entities, use cases, and repository contracts, showing that the project architecture separates what the application does from how data is stored or fetched.

The `features` layer organizes actual user-facing functionality into domains such as authentication, home, market, portfolio, watchlist, leaderboard, analytics, learning, trading, support, and settings. This improves clarity because each feature can evolve without creating disorder in unrelated parts of the codebase. From an academic perspective, this frontend structure demonstrates thoughtful engineering and modern application design principles.

## Page 20. Backend Architecture

The backend architecture is built using Django and Django REST Framework and follows a modular app-based organization. This architecture is appropriate because each backend module handles a well-defined set of responsibilities, making the system easier to extend and debug. The configured apps include users, market, portfolio, watchlist, leaderboard, and ml_api, in addition to standard Django applications.

The `users` app handles registration, login, and profile-related behavior. The `market` app manages stock records, market overview data, and chart candle data. The `portfolio` app maintains holdings, transactions, and simulated trade operations. The `watchlist` app supports personalized stock tracking. The `leaderboard` app handles performance ranking. The `ml_api` app connects the application to the machine learning layer through prediction and recommendation-related functionality.

The main URL configuration exposes all these modules under the `/api/` prefix. This creates a clean namespace for the frontend and keeps the backend structure organized. The settings module contains configuration for database access, timezone, CORS support, and ML artifact paths, making it possible for the application to serve both simulator logic and analytical endpoints from the same backend.

One important aspect of the backend architecture is the use of seeded demo data when required. This helps the simulator remain functional even when development databases are initially empty. For a student project, this is a practical and intelligent design decision because it supports testing, demonstration, and report screenshots without requiring a full live data ingestion system.

## Page 21. Firebase Integration

Firebase is incorporated into the project as an authentication and profile-support layer. In the Flutter codebase, dedicated providers and services are included for Firebase core, Firebase authentication, and Firestore. This indicates that the app is designed to support real identity flows rather than depending entirely on hardcoded local sessions. From a user experience perspective, this makes the project feel closer to a real-world application.

The importance of Firebase integration lies in simplifying account creation and login management. Authentication is often one of the more sensitive and complex parts of modern applications, especially when building from scratch. By using Firebase, the project leverages an established identity system for the app side while still maintaining backend synchronization for simulator-specific features such as profile balance, holdings, and trading history.

This hybrid approach is beneficial in an educational project because it allows the student to focus on application behavior while still demonstrating knowledge of cloud-integrated identity systems. It also reflects a common modern development pattern in which app authentication and backend business logic interact but are not always fully identical in implementation style.

At the same time, the project openly recognizes that full production-grade backend verification of Firebase tokens is a future enhancement. Including this point in the report is important because it shows engineering honesty and a realistic understanding of the current system maturity. The presence of Firebase integration thus adds practical relevance without overstating production readiness.

## Page 22. Machine Learning Integration and Architecture

Machine learning is integrated into Stock Simulator India as an enhancement layer rather than as the sole core of the application. This distinction is important. The simulator remains fully meaningful even without advanced ML accuracy because its primary purpose is stock market learning through interaction. However, ML adds analytical depth by supporting prediction and recommendation endpoints, which enrich the application and demonstrate how AI-related workflows can be connected to a broader system.

The project contains a separate `ml` workspace with datasets, scripts, models, notebooks, and requirements. This workspace includes stock universe data, scripts for fetching market data, building features, generating sample datasets, training baseline models, and evaluating them. Model files and metadata are stored under the `models` folder, and Django settings point to these artifacts using explicit path configuration.

The backend `ml_api` module serves as the bridge between the machine learning workspace and the application APIs. It exposes routes for ML home, engine status, stock prediction, and recommendation summary. Prediction results are stored as `PredictionSnapshot` entities, which means the analytical output is not merely temporary but also represented in the system as structured data.

Academically, this layer is very valuable because it demonstrates data-oriented thinking, artifact management, inference integration, and modular AI support. It shows that the project extends beyond frontend-backend communication and also attempts to include intelligent features, even if the current model is baseline in nature.

## Page 23. Module Overview

The system is organized into multiple modules so that each major feature can be implemented, tested, and documented separately. This modularity improves maintainability and also makes the report easier to structure. Instead of describing the application as one large block of functionality, it becomes possible to explain how each module contributes to the overall learning experience.

The primary modules are authentication, home dashboard, market exploration, stock details and charting, trading, portfolio management, transaction history, watchlist management, leaderboard comparison, and machine learning insight support. Additional supportive modules such as analytics, learning hub, challenges, achievements, notifications, profile, settings, and help pages broaden the application’s future potential and demonstrate thoughtful planning.

Each module corresponds to a stage in the user journey. Authentication gives the user access to the system. The dashboard provides orientation. Market and stock detail modules allow observation and analysis. Trading and portfolio modules create hands-on learning. Watchlist and leaderboard modules add continuity and motivation. Machine learning modules add interpretive support. This modular progression mirrors the educational purpose of the application.

The following pages describe each major module in detail so that both the functional and technical significance of the project can be understood clearly.

## Page 24. Authentication Module

The authentication module is one of the foundational modules of the project because it introduces user identity into the system. Without authentication, the simulator would be a generic interface with no personalized experience. By allowing users to register and log in, the application can maintain account-specific balance, holdings, watchlists, and history. This personalization is essential for any meaningful stock simulation platform.

On the Flutter side, the authentication feature includes login and register pages, authentication form widgets, providers, and authentication state handling. The use of dedicated providers indicates that authentication state is managed deliberately rather than mixed randomly with other feature logic. This improves clarity and keeps navigation decisions consistent.

On the backend side, the users module exposes routes for registration, login, and profile retrieval. During registration, the system reads user information such as name, email, and username, creates or updates a Django user record, and also creates or updates an associated `UserProfile`. This profile stores simulator-specific values such as display name, virtual balance, and demo account status. The login endpoint currently returns a demo token and serialized user information suitable for the development workflow.

The authentication module is educationally important because it demonstrates how identity flows operate across layers. It also creates the basis for the rest of the simulator, since all user-specific actions depend on account linkage.

## Page 25. Home Dashboard Module

The home dashboard acts as the user’s central entry point after successful authentication. In any educational financial application, the dashboard plays a critical role because it shapes the user’s first practical experience with the system. If the dashboard is cluttered, confusing, or disconnected from the main objectives, users may feel overwhelmed. Therefore, the home dashboard in this project is designed to provide overview, direction, and quick access to important features.

The Flutter codebase includes a dedicated `home` feature with a page, provider, and widgets such as market index cards, trending stock tiles, and portfolio summary cards. This reflects a useful dashboard philosophy: combine overview data with action-oriented entry points. Instead of making the user search manually for all information, the dashboard can present current market highlights, quick portfolio context, and paths to detailed pages.

From a technical point of view, the dashboard is a strong example of component-based UI design. Small reusable widgets are combined into a meaningful higher-level screen. This makes the dashboard easier to maintain and also improves visual consistency throughout the application.

From a learning perspective, the dashboard helps users understand where they stand and what they can do next. It creates a bridge between identity and action, which is why it is one of the most important UX modules in the project. In the final Word report, a screenshot of the dashboard should be placed on this page.

## Page 26. Market Exploration Module

The market module is the foundation of the simulator because users cannot make informed trading decisions unless they can first browse and observe stocks. This module provides the stock list and market overview that introduce users to the available securities in the application. The backend market app exposes routes for market home, overview, stock list, stock details, and chart data.

The market overview endpoint returns index-style summary values such as NIFTY 50, SENSEX, and BANK NIFTY. Including these indices increases realism because it mirrors the way financial applications often present broader market context before drilling down into individual stocks. The stock list endpoint returns available stock records, including data such as symbol, company name, sector, current price, daily change, daily percentage change, volume, day high, and day low.

An important feature of the module is the demo seeding mechanism. If the database does not yet contain stocks, the market logic can load a universe from a CSV file or fall back to a mock list. This ensures that the simulator remains functional in development and demonstration environments. The prices and chart data are deterministically generated, which creates repeatable behavior suitable for testing.

On the frontend side, the market feature includes a market page, search behavior, stock cards, and provider logic. This makes the module not only technically central but also visually central to the application experience. It gives users the raw material from which trading decisions emerge.

## Page 27. Stock Details and Chart Module

The stock details module extends the market exploration module by allowing the user to examine a specific stock more closely. Educationally, this step is important because real understanding of trading begins when users move beyond general browsing and start asking focused questions about individual securities. A stock details page is where such focused learning becomes possible.

In the backend, the stock details endpoint returns full information for a given symbol. The chart endpoint returns both a simple point array and serialized candle data. The project generates seven data points for the one-day interval using seeded values. While this is not the same as real-time historical charting, it is sufficient for demonstrating chart behavior, frontend rendering, and stock observation workflows in an academic simulator.

On the Flutter side, the stock details feature includes a dedicated page, provider, chart widget, stock stats grid, and a buy-sell bottom sheet. This shows that the page is not merely descriptive. It is designed as an action-enabling page where users can observe information and then directly take a simulated trading decision. That coupling between observation and action is educationally useful and architecturally sound.

This module also serves as a natural place for machine learning insight cards, because users usually want predictive or recommendation context while examining a particular stock. The stock details page therefore becomes one of the richest screens in the system.

## Page 28. Trading Module

The trading module is the heart of the paper trading experience. It is the place where the application moves from information display to consequence-producing interaction. A user who views stock information but cannot perform any action is still only a passive observer. Trading introduces decision-making, risk simulation, and measurable outcomes. That is why this module is central to the educational purpose of the project.

The backend portfolio app exposes `buy` and `sell` endpoints that implement the main trading rules. During a buy action, the system first confirms that the stock exists. It then checks whether the user has sufficient virtual balance to complete the purchase. If the validation succeeds, the system creates or updates a holding, recalculates the average acquisition price, reduces the user’s virtual cash, and stores a transaction entry. During a sell action, the system verifies that the user owns enough quantity of the selected stock. If valid, it reduces the quantity or removes the holding entirely, credits virtual cash back to the profile, and records the transaction.

From an algorithmic perspective, these actions are simple but meaningful. They teach the user that every trade affects both liquid balance and invested holdings. They also show the importance of validating availability before order execution. Even though the project does not implement full exchange-level order matching, it still captures the essential educational dynamics of stock trading.

On the frontend side, the presence of buy or sell bottom sheets and additional trading-related pages such as order preview, order book, limit order, stop loss, open orders, and confirmation pages indicates a broader trading vision. This makes the project feel like a genuine platform rather than a minimal demo.

## Page 29. Portfolio Management Module

The portfolio module is one of the most educationally important modules because it reflects the consequences of all prior trading decisions. If the trading module represents action, then the portfolio module represents reflection. It is where users understand whether their decisions increased or decreased the value of their virtual holdings and how much capital remains available for future trades.

The backend `portfolio_summary` endpoint computes cash balance, portfolio value, profit or loss, and serialized holdings. Each holding stores the stock, quantity, and average purchase price for a specific user. Portfolio value is derived from the current market value of held shares, while invested value depends on acquisition prices. Profit or loss is calculated by comparing these figures. This gives the portfolio page real educational meaning rather than merely static content.

The Flutter frontend contains a dedicated portfolio page, transaction history page, providers, and widgets such as holding cards and allocation charts. The use of charts and summary cards helps convert abstract numbers into understandable visual feedback. This is important because beginner users often learn faster when portfolio movement is shown in both numeric and visual form.

The portfolio module also reinforces the idea that learning trading is not just about individual buy and sell events. It is about understanding how those events combine over time into an overall financial position. That makes this module central to both the simulator logic and the educational purpose of the project.

## Page 30. Transaction History Module

The transaction history module records the detailed sequence of trade events and allows users to revisit their previous actions. In stock market learning, transaction history is highly important because it connects present portfolio state with past decisions. Without such a record, users would see outcomes but not the actions that caused them.

Each backend transaction stores the user, stock, order type, quantity, price, total amount, and execution timestamp. This gives the system a structured trail of simulated trading activity. The transaction history endpoint returns these records in reverse chronological order. If no records exist yet, the system can return sample entries, which is a useful development strategy because it keeps the UI demonstrable before extensive user interaction has occurred.

From a user perspective, transaction history encourages reflective learning. A beginner can review which stocks were purchased, at what price, and when. This helps users recognize patterns in their own behavior and better understand why current holdings or balances appear the way they do. It is also a useful feature for demonstrations and academic presentations because it makes the simulator feel more complete and realistic.

The frontend transaction history page, provider, and transaction tile widgets demonstrate that this module has been considered as a full user-facing experience rather than only a backend storage table.

## Page 31. Watchlist Management Module

The watchlist module allows users to save stocks that they want to observe without immediately buying them. This is a realistic feature because real trading applications often use watchlists as an intermediate step between market awareness and actual order placement. Educationally, it is valuable because it supports patient observation and comparison rather than encouraging immediate action.

The backend represents each watchlist item as a relationship between a user and a stock. This simple structure is effective because it reflects the actual purpose of the feature: the user is not changing the market or the portfolio, but merely indicating interest in a security. The API provides routes for listing watchlist items, adding a stock to the watchlist, and removing one. If the user does not yet have any items, default seeded stocks may be added to support initial demonstration.

The Flutter project includes a watchlist page, a provider, and widgets for displaying watchlist stocks. This means the feature is integrated into the user flow rather than being an afterthought. It helps users learn that market participation often begins with observation. A user does not have to buy every interesting stock immediately; they can monitor it first.

As a design choice, the watchlist also improves the overall usability of the application because it gives users a way to personalize their market space. This increases engagement and makes the simulator feel more dynamic and user-centered.

## Page 32. Leaderboard Module

The leaderboard module introduces comparison and motivation into the simulator. While stock market learning can be an individual process, a comparative feature adds excitement and helps sustain user interest. In educational applications, such competitive or semi-competitive elements can increase engagement when implemented thoughtfully.

The backend `LeaderboardEntry` model stores user-specific ranking information for a defined period, such as weekly performance. Fields include portfolio value, returns percentage, rank, and update time. The rankings endpoint returns these entries in sorted order. When no entries are present, the backend seeds demo users and sample ranking values so that the feature remains demonstrable.

This module is useful because it extends the simulator beyond a private notebook-like experience. Users can see that their performance exists in relation to others. Even in a demo environment, this creates a sense of progression and participation. It also provides another perspective on portfolio results: not just how much one has earned or lost, but how one compares relative to peers.

The Flutter leaderboard page, provider, and tile widgets present this data in an accessible visual format. In the final report, a screenshot or sample table from the leaderboard should be included to illustrate the module’s role in the system.

## Page 33. Additional and Supporting Features

One of the strengths of the project is that it is not limited only to the core market, trading, and portfolio cycle. The Flutter codebase contains a number of additional feature pages that extend the vision of the application. These include learning-related pages, notes, lectures, market summary pages, analytics pages, challenges, achievements, alerts, news views, notifications, streak tracking, profile, help and support, FAQ, feedback, and about pages.

Even if some of these areas are currently more developed at the interface level than at the full business-logic level, they are still important because they show product planning beyond a minimal prototype. A strong academic project should ideally demonstrate both implemented functionality and a coherent expansion path. These extra features do exactly that. They show how the simulator can evolve into a broader financial learning platform rather than staying limited to a simple demo of buying and selling.

For example, a learning hub can provide educational content that complements practical simulation. Analytics pages can help users interpret their portfolio behavior more deeply. Alerts and notifications can increase app engagement. Challenges and achievements can gamify learning and motivate repeated usage. Support pages improve user trust and completeness.

Thus, the supporting features are not merely decorative. They reveal the larger product direction of the application and strengthen the academic presentation of the project by showing long-term design thinking.

## Page 34. Workflow Overview

The workflow of Stock Simulator India begins when the user launches the application. The splash screen acts as the entry point and is followed by the authentication flow if the user is not already recognized. Through the register or login screen, the user gains access to the personalized environment of the simulator. This step is important because the subsequent application state depends on user identity.

After authentication, the user is taken to the home dashboard. The dashboard provides an overview of the simulator environment and serves as the central navigation hub. From there, the user can move into the market module to browse available stocks. Once a stock is selected, the stock details page displays key information, chart data, and trading options.

If the user chooses to buy or sell, the frontend sends the request to the backend, which validates the action and updates the relevant models. Once the trade is processed, its impact becomes visible in the portfolio summary and transaction history. The user may also add stocks to a watchlist without immediately trading them, which supports observation and delayed decision-making. The leaderboard further extends the workflow by allowing comparative performance review.

If machine learning support is available, the user may also receive prediction or recommendation-oriented insights related to the selected stock or overall recommendation output. In this way, the workflow is not a single linear path but a recurring learning cycle: observe, decide, simulate, evaluate, and refine understanding.

## Page 35. Data Flow Diagram Explanation

Data flow in the project begins at the user interface level. When the user interacts with the Flutter application, the app collects input such as login credentials, selected stock symbols, requested quantities, or watchlist actions. This data is passed through providers, services, and remote data sources to construct requests for backend APIs.

The request is then sent using Dio to the Django backend. At the backend level, the appropriate app module processes the request. For example, the users module handles registration-related data, the market module handles stock-related queries, and the portfolio module handles trade-related modifications. Business logic is applied centrally in the backend rather than in the UI, which is a strong design decision because it protects rule consistency.

Where necessary, the backend reads from or writes to the SQLite database. If the request involves prediction or recommendation behavior, the backend `ml_api` service invokes the insight engine and may load model metadata or trained artifacts from the machine learning workspace. Once processing is completed, the backend returns a JSON response to the frontend, which then updates the visible UI.

This data flow model demonstrates separation of concerns and layered processing. It is important in the final report to include a data flow diagram on this page so that the interaction between user, frontend, backend, database, and ML layer becomes visually clear.

## Page 36. Registration and Login Workflow

The registration workflow begins when a new user enters personal details on the Flutter registration page. Firebase Authentication assists the app in handling account creation, which provides a practical and recognizable identity mechanism. Once the app-side account flow succeeds, the frontend communicates with the Django backend so that a simulator-specific user record can also be created or updated.

The backend `register_user` endpoint collects values such as name, email, username, first name, and last name. If the user does not already exist in the Django database, a new `User` record is created. A corresponding `UserProfile` is also created with values such as display name, initial virtual balance, and demo account status. If the user already exists, profile information is updated rather than duplicated. This behavior ensures consistency and avoids unnecessary duplicate records.

The login workflow is simpler in the current development version. The backend login route identifies a user and returns a demo token along with serialized user information. Although this is not yet a full production-grade token verification model, it is adequate for project demonstration and frontend integration.

The workflow is important because it shows how frontend identity handling and backend simulator identity can cooperate. It also provides the foundation required for all personalized features in the project. In the Word report, this page should ideally contain a sequence diagram showing the registration and login steps between user, Flutter, Firebase, and Django.

## Page 37. Trading Workflow

The trading workflow begins when the user opens the stock details page and decides to buy or sell a stock. The frontend presents the selected symbol, stock details, and action controls. When the user submits a quantity, the application sends the request to the backend using the appropriate endpoint.

For a buy request, the backend first ensures that the stock exists in the market dataset. It then retrieves the user profile and checks whether the virtual balance is sufficient for the requested purchase quantity at the current stock price. If the balance is insufficient, the system returns an error response. If the purchase is valid, the system updates or creates a holding for that stock, recalculates the average purchase price, deducts the amount from virtual cash, and stores a transaction record of type `BUY`.

For a sell request, the backend verifies that the stock exists and that the user holds enough quantity. If the holding is missing or insufficient, the sell is rejected. If valid, the system reduces the quantity or deletes the holding when it reaches zero, credits the sale amount back to the virtual balance, and stores a `SELL` transaction record.

The educational value of this workflow is high because it makes financial cause and effect visible. Each trade changes both portfolio state and cash balance. This is precisely the type of hands-on learning that the project is designed to support.

## Page 38. Portfolio Update Workflow

The portfolio update workflow is triggered whenever a trade occurs or whenever the portfolio summary page is loaded. The backend retrieves all current holdings associated with the user and calculates their present market value using the current prices stored in the stock records. This value is then combined with the user’s available virtual cash to represent the user’s total simulation position.

To calculate invested value, the backend multiplies the quantity of each holding by its average acquisition price. Profit or loss is then calculated as the difference between the current market value of holdings and the invested value. This gives the user a simple but meaningful measure of performance.

The portfolio workflow also includes conditional seeding behavior. If no holdings or transactions exist yet, default demo holdings may be created for development visibility. This design supports application screenshots and testing without forcing the developer to execute many manual trades first.

The frontend then uses the returned portfolio data to populate cards, charts, and holding lists. This workflow is important in the report because it demonstrates the connection between backend calculation and frontend financial interpretation. A flowchart or data table should be added on this page in the final Word version.

## Page 39. Database Design Overview

Database design is one of the core technical aspects of the project because it determines how application state is stored, retrieved, and connected across modules. Stock Simulator India uses a relational data model implemented through Django ORM and backed by SQLite in the current development environment. This choice is practical and sufficient for academic implementation while still allowing clear representation of user activity, market data, and analytical outputs.

The database is organized around several major entities: user profile, stock, stock candle, holding, transaction, watchlist item, leaderboard entry, and prediction snapshot. Each entity is connected to others through meaningful relationships. For example, a user can have many holdings, many transactions, many watchlist items, and possibly one or more leaderboard entries depending on period labels.

The `Stock` entity forms the basis of market data. The `Holding` and `Transaction` entities form the basis of simulated investment behavior. The `WatchlistItem` entity captures personalized observation. The `LeaderboardEntry` entity supports comparative ranking. The `PredictionSnapshot` entity represents the analytical layer. This structure provides a balanced representation of operational, historical, and predictive data.

Using Django models makes the schema easy to maintain and migrate. From an academic documentation point of view, the database design is strong because it is neither trivial nor unnecessarily complex. It supports the project’s goals in a direct and understandable manner. An ER diagram should be inserted on this page in the final report.

## Page 40. User and Profile Entity Design

The system uses the built-in Django user model for core identity and extends it through a `UserProfile` model. This is a common and effective design pattern because it allows the application to leverage Django’s authentication foundations while also storing project-specific user data separately. In this simulator, the profile stores fields such as display name, virtual balance, demo account status, and timestamps.

The use of a one-to-one relationship between the user and the profile is technically appropriate because every authenticated simulator user should have one corresponding simulator profile. The profile is particularly important because it holds the virtual balance used in all trading calculations. Without this layer, simulator-specific financial state would have to be mixed into the base user model, which would reduce clarity.

This design also helps keep the code modular. Authentication and profile state can evolve independently. For example, the project could later introduce profile preferences, avatar settings, learning progress, or risk profile fields without disturbing the core identity model.

From the report perspective, the user-profile structure demonstrates that the project handles identity thoughtfully and does not depend on superficial screen-level account handling alone.

## Page 41. Stock and Market Entity Design

The market side of the database revolves around the `Stock` and `StockCandle` entities. The `Stock` model stores key descriptive and pricing fields such as symbol, company name, sector, description, current price, daily change, percentage change, day high, day low, volume, active status, and timestamps. This structure is appropriate because it captures both descriptive and operational market attributes in one entity.

The `StockCandle` model stores interval-based price information such as open, high, low, close, volume, and recorded time. Its foreign key relationship to `Stock` allows each security to maintain a sequence of chart points. This is important because the stock details page becomes more informative when users can observe chart-like movement rather than only current price.

The market entity design is intentionally lightweight but effective for the simulator’s goals. It does not attempt to reproduce the full complexity of institutional trading data, but it includes enough structure to support browsing, analysis, and trading simulation. This balance is suitable for educational software and practical report presentation.

The final Word report should ideally include a table showing each stock-related field and its purpose so that examiners can quickly understand the database design.

## Page 42. Portfolio and Transaction Entity Design

The `Holding` entity is central to the project because it represents the current ownership state of the user. It stores the user, the stock, the number of shares held, the average acquisition price, and the update time. The unique combination of user and stock ensures that each stock appears only once in a user’s active holdings, which simplifies calculation and avoids duplication.

The `Transaction` entity stores the historical record of trading actions. Fields include user, stock, order type, quantity, execution price, total amount, and execution time. This design allows the application to differentiate current state from historical state. Holdings explain what the user owns now; transactions explain how the user arrived there.

This separation is good database design because current portfolio state and historical trading logs serve different purposes. If only transactions existed, portfolio reconstruction would become more computationally expensive and conceptually less clear. If only holdings existed, the user would lose learning visibility into past actions. By using both, the system supports both operational efficiency and educational transparency.

In the report, these two entities should be discussed together because they form the main financial data backbone of the simulator.

## Page 43. Watchlist, Leaderboard, and ML Snapshot Entities

The `WatchlistItem` entity is designed as a simple user-stock relationship with a creation timestamp. This simplicity is appropriate because the watchlist feature is conceptually simple: it records user interest in a stock without affecting portfolio value or transaction history. The design is lightweight and effective.

The `LeaderboardEntry` entity captures comparative ranking information. By storing user, period label, portfolio value, returns percentage, rank, and update time, the application can support weekly or future multi-period comparisons. This is useful not only for current ranking but also for possible future historical competition tracking.

The `PredictionSnapshot` entity stores the output of the ML prediction system, including symbol, prediction, confidence, risk score, source, and timestamp. This is an especially nice design choice because it gives the ML layer persistence inside the backend rather than treating predictions as disposable outputs. It also helps demonstrate in the report that the analytical layer is connected meaningfully to the application data model.

Together, these three entities show how the project extends beyond core trading and includes personalization, social comparison, and analytics.

## Page 44. API Design Overview

The backend follows a REST-style API design organized under the main `/api/` route. This structure is effective because it groups related functionality into clean namespaces and creates predictable endpoints for the frontend. Each backend module exposes its own route group, making the application easier to integrate and document.

The major route groups are `/api/users/`, `/api/market/`, `/api/portfolio/`, `/api/watchlist/`, `/api/leaderboard/`, and `/api/ml/`. Each module also provides a small base or home route that returns a module-ready status message, which is useful for quick verification during development and debugging.

The API design favors simple, readable JSON responses over unnecessary complexity. This is a good fit for a student project because it emphasizes clarity and correctness. The routes are directly aligned with the major functional modules of the application, which means the API is not only technically workable but also easy to explain in academic documentation.

In the final report, a table summarizing route path, method, purpose, request body, and sample response should be inserted on this page.

## Page 45. Users API Design

The users API includes endpoints for users home, registration, login, and profile access. The users home route provides a simple readiness message. The registration route accepts user details such as name, email, and username and performs either user creation or update as required. It also ensures that a corresponding simulator profile exists.

The login route currently uses a development-friendly pattern in which it returns a demo token and user information. While the long-term production model would involve stronger backend token validation, the current design is suitable for app connectivity and academic demonstration. The profile route returns serialized user information for the logged-in or demo-linked user.

This API design is important because it defines how the frontend transitions from general app use to personalized simulator behavior. It also demonstrates how user registration and simulator profile creation can be connected within a clean API structure.

For the final report, this page should include example JSON payloads for registration and login so that the evaluator can clearly understand the contract between frontend and backend.

## Page 46. Market API Design

The market API is one of the richest route groups in the application. It includes endpoints for base market readiness, market overview, stock list retrieval, stock details by symbol, and stock chart retrieval by symbol. These routes collectively support broad market browsing and specific stock analysis.

The overview endpoint provides index-style summary data. The stock list endpoint returns serialized stock records for all active stocks. The stock details endpoint returns full details about a selected security. The chart endpoint returns points and candles suitable for frontend chart display. Together, these routes provide the informational context necessary for the user to make trading decisions.

The design is effective because it separates broad data from detailed data. The user can first load a list or overview, then request details for a specific stock only when needed. This reduces unnecessary data transfer and matches the typical navigation flow of market applications.

This page of the report should include a table or screenshot of sample responses, especially for stock details and chart endpoints, because these are visually useful and central to the simulator experience.

## Page 47. Portfolio, Watchlist, and Leaderboard API Design

The portfolio API contains routes for portfolio home, summary, buy, sell, and transactions. These routes are central because they carry the business logic of the simulator. The summary route returns cash balance, holdings, portfolio value, and profit or loss. The buy and sell routes process user actions and change database state accordingly. The transactions route returns historical activity data.

The watchlist API contains routes for home, item listing, add-to-watchlist, and remove-from-watchlist actions. It is intentionally simpler because watchlist operations do not require complex financial calculation. Its purpose is personalization and observation support.

The leaderboard API contains base readiness and rankings routes. The rankings route returns current leaderboard entries, typically for a weekly performance period. Although technically simpler than portfolio logic, it adds important user engagement and comparative context.

These APIs should be discussed together in the report because they collectively represent the behavior of user-specific simulator features. A combined API table with input-output examples can be included on this page to improve readability.

## Page 48. Machine Learning API Design

The ML API extends the simulator beyond basic trading by exposing analytical routes. These include the ML home route, the engine status route, the prediction route for a stock symbol, and the recommendation summary route. This design is valuable because it gives the frontend a clear and stable interface for analytical outputs without requiring the frontend to know anything about how the model is trained or stored.

The engine status route is especially useful in development because it reveals whether models, metadata, and stock universe files are available. The prediction route accepts a symbol and can also accept a horizon query parameter, then returns a prediction snapshot after invoking the insight engine. The recommendation route returns grouped recommendation output along with engine information.

From an architectural perspective, the ML API is well designed because it isolates ML concerns within one backend module. That means improvements to the model, feature engineering process, or fallback logic can occur with minimal change to the frontend contract. The frontend simply reads the prediction or recommendation response in the format it expects.

For the final report, example outputs should be inserted on this page to show how the analytical layer appears from the perspective of the application.

## Page 49. Demo Data Seeding Logic

A notable design feature of the project is its use of deterministic demo data seeding. In many student projects, the absence of real production data makes it difficult to create a stable and presentable system. Stock Simulator India addresses this challenge intelligently by using controlled stock seeding logic. If the application database lacks stock records, the backend attempts to read from a stock universe CSV and, if necessary, falls back to a smaller internal stock list.

For each stock symbol, helper functions generate a repeatable price seed, price change, and chart series based on symbol characters. This approach creates realistic-looking but deterministic data, which is excellent for debugging, screenshots, and presentations. Because the same symbol will always generate the same seeded pattern, the simulator remains consistent during repeated runs.

This logic also extends to other modules. Default watchlist items, demo holdings, sample transactions, and leaderboard entries can be created when required. Such design decisions are extremely practical because they reduce setup friction and ensure the app remains demonstrable even in early or partially reset environments.

In the report, this page should emphasize that seeding is not a shortcut but a thoughtful solution to the challenge of educational simulation without live market infrastructure.

## Page 50. Trade Calculation Logic

The trade calculation logic is one of the most important algorithmic aspects of the project. When a user buys a stock, the system must do more than simply create a record. It must ensure that the transaction is financially valid within the virtual environment and update the user’s portfolio state accurately.

For a buy operation, the backend calculates `total_amount = quantity × current_price`. It then compares this amount to the available virtual balance in the user profile. If the balance is sufficient, the holding is either created or updated. If the user already owns shares of the stock, the average purchase price must be recalculated using weighted average logic. This is achieved by combining previous holding cost and new purchase cost and dividing by the new total quantity.

For a sell operation, the system checks whether the user holds enough shares. If the user does, the quantity is reduced, and the total sale value is credited back to virtual cash. If the resulting quantity becomes zero, the holding is deleted entirely. In both buy and sell cases, a transaction record is created. These steps together ensure internal consistency of the simulator.

Including this logic in the report is important because it demonstrates that the project includes actual financial behavior modeling, not just screen transitions.

## Page 51. Machine Learning Logic and Fallback Design

The machine learning logic in the project is intentionally designed to be supportive and resilient. The backend uses an insight engine that checks whether trained model artifacts, metadata files, and stock universe data are present. If the required resources are available, the backend can provide model-based predictions. If not, the design still allows the system to operate with fallback logic or development-friendly responses. This approach is important because it prevents the simulator from becoming unusable just because ML artifacts are missing or being retrained.

The project supports multiple horizons, such as short and long models, through explicit settings paths. This indicates that the system is prepared to handle different time horizons rather than a single rigid prediction style. The prediction output typically includes symbol, prediction label, confidence score, risk score, and source type. Recommendation output provides grouped insights across symbols or strategies.

Academically, the fallback design is significant because it reflects good engineering practice. Real systems should degrade gracefully when advanced features are temporarily unavailable. The ML layer in this project follows that principle by being additive rather than destructive. The simulator remains useful as a stock learning platform even when the analytical layer is being improved.

This page should include a short explanation of how model inference differs from rule-based or fallback behavior.

## Page 52. Flutter Implementation Details

The Flutter implementation demonstrates significant effort in screen organization, provider usage, networking separation, and reusable UI design. The presence of app-wide constants, router definitions, theme files, interceptors, services, and utility helpers indicates that the frontend was designed as a real application architecture rather than a collection of isolated pages.

Feature modules such as authentication, home, market, portfolio, watchlist, leaderboard, analytics, support, and learning each contain their own presentation pages and often providers or widgets. This is a strong sign of thoughtful structure. Data models are separated by domain, such as market, portfolio, stock, user, and leaderboard models. Repositories and data sources suggest a layered approach to data fetching and transformation.

The use of Dio for backend communication and Riverpod for state management improves maintainability. It allows application logic to remain clearer and makes it easier to test or evolve components later. Utility widgets like stock list tiles, price change chips, section headers, loaders, and error views improve consistency across screens.

Overall, the Flutter implementation is one of the strongest technical dimensions of the project and should be highlighted properly in the report.

## Page 53. Django Implementation Details

The Django implementation is equally important because it carries the simulator’s actual business rules. The project includes models, serializers, views, URLs, and migrations across multiple apps, which demonstrates modular backend development rather than monolithic scripting. This structure is well aligned with the needs of a stock simulation platform.

The `market` app handles both stock information and chart data. The `portfolio` app handles holdings and transactions, which are two of the most important backend entities. The `users` app manages profile creation and identity-linked state. The `watchlist` and `leaderboard` apps add personalization and engagement. The `ml_api` app bridges the analytics layer into the same backend ecosystem.

Django REST Framework is used effectively to produce JSON responses suitable for Flutter consumption. The inclusion of home or health endpoints for each module also helps development and debugging. The settings file explicitly references ML model paths and enables CORS, which is practical for app-backend communication during development.

The Django implementation shows clear evidence of backend engineering, not merely database storage. This makes it a strong talking point in the major project report and viva discussion.

## Page 54. User Interface and User Experience Considerations

User experience is especially important in an educational project because the success of the system depends not only on technical correctness but also on how easily users can understand and navigate it. In Stock Simulator India, the UI is designed to remain clear, structured, and relatively beginner-friendly. The presence of separate pages for login, dashboard, stock browsing, portfolio review, and settings helps users mentally organize the application.

Reusable components improve consistency, which is an important UX principle. When buttons, cards, list tiles, and summary widgets behave consistently, the user can focus on learning the stock workflow rather than adapting to changing visual patterns. Theme files and utility widgets in the Flutter project support this consistency.

The interface design also reflects the importance of gradual information layering. The user is not overloaded with every detail at once. Instead, the dashboard gives summary context, the market page gives browsing context, and the stock details page gives focused analysis. This staged presentation is useful for beginners who may not be comfortable processing financial data all at once.

In the final report, screenshots should be placed strategically to demonstrate that the project is visually organized as well as technically functional.

## Page 55. Security and Reliability Considerations

Even though the project is educational in nature, security and reliability remain important considerations. Any application involving user identity and persistent data should demonstrate at least a reasonable awareness of secure design practices. In this project, Firebase is used to support app-side authentication, and the backend maintains user-related records for simulator functionality. This is a strong start because it avoids a fully naive identity model.

The backend is also structured enough to centralize important business rules rather than leaving them to the client side. This improves reliability because trade validation, balance checks, and holding modifications all happen server-side. If such logic existed only in the frontend, simulator correctness would be much weaker.

At the same time, the project openly acknowledges areas for improvement. A production-level system would require stricter backend verification of Firebase ID tokens, stronger permission checks, secure secret handling, more restrictive CORS configuration, and fuller audit-oriented logging. By stating these limitations clearly, the report demonstrates maturity and realism.

Reliability also benefits from deterministic seeding and modular design. These design features make the system easier to reproduce, test, and present consistently.

## Page 56. Testing Strategy

Testing in a full-stack project should not be limited to one layer. Since Stock Simulator India includes frontend UI, backend business logic, and ML-related endpoints, the testing strategy must include multiple forms of validation. Functional testing is needed to verify whether major user actions such as registration, stock browsing, buying, selling, watchlist updates, and portfolio viewing behave correctly. Integration testing is needed to verify that the frontend and backend communicate correctly. Structural validation is needed to ensure that modules, routes, and data models align properly.

A practical testing strategy for this project includes checking all key backend routes manually or through lightweight tests, verifying that the frontend renders expected data, and confirming that ML status endpoints correctly report model availability. Because the application uses seeded data, it becomes easier to test consistent scenarios repeatedly. For example, seeded stocks allow predictable market list results, while seeded leaderboard or watchlist data makes those features easier to inspect.

Testing should also consider negative scenarios. Examples include attempting to buy without sufficient balance, attempting to sell more shares than owned, or requesting a non-existent stock symbol. These checks are important because they validate not only happy paths but also error handling.

The final Word report should include a test case table on this page, with columns such as test ID, feature, input, expected output, actual result, and status.

## Page 57. Backend Validation and Integration Status

The backend shows a strong level of structural validation because all major modules are present and connected through the central URL configuration. The existence of dedicated views, models, serializers, and routes for each app indicates that the project is more than a partial prototype. It has a coherent backend architecture capable of supporting practical simulator behavior.

Module-level readiness routes help confirm that APIs are reachable. The registration route creates or updates user and profile records. The market routes return stock and chart data. The portfolio routes support summary, buy, sell, and transaction history. The watchlist, leaderboard, and ML modules likewise expose meaningful responses. This breadth of implemented behavior is significant in a student project.

Integration readiness is also supported by the frontend’s use of data sources, repository implementations, and providers. The app is architecturally prepared to consume backend responses in a clean way. Although full production-level end-to-end validation may still be in progress, the existing structure strongly supports integration.

In the report, this page should describe backend validation results in a balanced way, emphasizing both what has been successfully implemented and which areas still need more exhaustive runtime testing.

## Page 58. Strengths and Advantages of the Project

Stock Simulator India has several strengths that make it a meaningful and technically solid project. One major strength is its practical relevance. The problem it addresses is real: many users want to learn stock trading but are afraid of risking real money. By creating a paper trading environment, the project directly addresses this challenge in a useful and understandable way.

Another major strength is its full-stack nature. The project is not limited to a basic interface or a single backend script. It integrates Flutter, Django, Firebase, and machine learning into one cohesive application. This makes it richer academically and more impressive technically. The modular architecture also improves maintainability and future expandability.

Feature coverage is another strength. The application includes not only login and stock listing but also stock detail charts, buy and sell simulation, portfolio management, transaction history, watchlist handling, leaderboard ranking, and prediction or recommendation endpoints. This gives the project breadth and depth.

Finally, the project has strong expansion potential. The existing architecture is flexible enough to support better security, richer data sources, improved analytics, and more advanced user engagement features in later versions.

## Page 59. Limitations of the Project

Despite its strengths, the project also has limitations that should be recognized clearly. The first limitation is that the simulator does not connect to real stock exchange infrastructure and therefore does not support live market execution. It uses seeded or development-stage data rather than real-time trading integration. This is acceptable for an educational simulator, but it limits real-market realism.

A second limitation is that the current authentication and backend authorization flow is still in a developmental state. Firebase is integrated on the app side, but full production-grade backend verification and security hardening are future needs rather than completed features. This means the system is academically useful but not yet ready for commercial deployment.

The machine learning layer is another area with limitations. The current models are baseline models, and their outputs should not be interpreted as reliable investment advice. They are included mainly to demonstrate integration of analytics, not to claim production accuracy. Testing coverage, especially complete end-to-end runtime validation across all frontend pages and device contexts, is also an area that can be strengthened further.

Acknowledging these limitations is important because it shows a realistic engineering mindset and improves the credibility of the report.

## Page 60. Future Scope

The future scope of Stock Simulator India is broad and promising because the current implementation already establishes a strong structural foundation. One major future direction is stronger authentication and authorization. This includes full Firebase ID token verification at the backend level, protected API access patterns, and more refined user-specific security controls.

Another future improvement is richer market realism. The simulator can be extended to support more stocks, better historical chart data, and eventually near-real-time market refresh. Advanced analytics such as sector comparison, portfolio diversification score, drawdown tracking, and personalized performance insights can also be added.

The machine learning layer has significant room for enhancement. Better datasets, stronger feature engineering, improved target definitions, and more realistic validation methods can increase model quality. Recommendation outputs can become more meaningful and better integrated into the user journey.

From a product perspective, the app can expand its learning hub, challenge systems, educational notes, and strategy-based portfolio simulation. Over time, the platform could evolve into a richer learning ecosystem rather than just a trading simulator. This future scope makes the project not only complete enough for submission but also worthy of continued development.

## Page 61. Conclusion

Stock Simulator India is a meaningful full-stack project developed to provide users with a safe, interactive, and educational environment for learning stock market behavior. It addresses a practical problem faced by beginners who wish to understand trading workflows but do not want to risk real money during their learning process. By enabling virtual buying and selling, watchlist management, portfolio analysis, and leaderboard comparison, the project converts theoretical financial interest into hands-on understanding.

The project successfully combines Flutter for user interface development, Django and Django REST Framework for backend logic and API creation, Firebase for authentication-related support, and a Python-based machine learning workspace for analytical enhancements. This combination reflects strong software engineering integration and demonstrates how multiple technologies can work together to solve a user-centered problem.

One of the project’s strongest achievements is that it goes beyond a static or superficial prototype. It includes modular architecture, meaningful data models, consistent API routes, trading and portfolio logic, and an extendable analytical layer. These characteristics make it valuable not only as an educational product but also as a substantial academic implementation.

Although areas such as production security, real-time data integration, and advanced model quality remain open for future improvement, the project has successfully achieved its core purpose. It stands as a strong example of applied full-stack development and a useful simulator for beginner stock market learning.

## Page 62. References

Suggested references for the final report include the following:

Flutter Documentation. Official documentation for Flutter framework and widget-based UI development.

Django Documentation. Official documentation for the Django web framework.

Django REST Framework Documentation. Official documentation for API development using Django REST Framework.

Firebase Documentation. Official documentation for Firebase Authentication, Firestore, and app service integration.

pandas Documentation. Official documentation for data analysis and preprocessing in Python.

scikit-learn Documentation. Official documentation for machine learning model training and evaluation.

joblib Documentation. Official documentation for model serialization and persistence.

Any institutional report template references, stock market education texts, or academic papers on simulation learning may also be added based on your college requirements.

## Page 63. Appendix A: Suggested Screenshots

This appendix should include screenshots from the actual project implementation so that the report contains direct visual evidence of system behavior. The most useful screenshots are:

- splash screen
- login page
- registration page
- home dashboard
- market list page
- stock details page with chart
- buy or sell interaction view
- portfolio summary page
- transaction history page
- watchlist page
- leaderboard page
- settings or profile page

Each screenshot should be given a proper figure number and a short caption explaining what is being shown. If needed, two related screenshots can be placed on a single Word page with careful formatting.

## Page 64. Appendix B: Sample API Responses

This appendix page should contain sample JSON outputs from the backend. Suggested examples include:

- response from `/api/market/overview/`
- response from `/api/market/stocks/`
- response from `/api/market/stocks/RELIANCE/`
- response from `/api/portfolio/summary/`
- response from `/api/watchlist/items/`
- response from `/api/leaderboard/rankings/`
- response from `/api/ml/status/`
- response from `/api/ml/predict/RELIANCE/`

These outputs are useful because they show the practical structure of the backend and make the project documentation more concrete. They also help support viva questions related to API design and frontend-backend integration.

## Page 65. Appendix C: Suggested Diagrams

The final report should include several diagrams to improve presentation quality and technical clarity. Suggested diagrams are:

- overall system architecture diagram
- frontend architecture diagram
- backend modular app diagram
- data flow diagram
- user registration sequence diagram
- trading workflow diagram
- entity relationship diagram
- ML pipeline diagram

Even simple diagrams created in draw.io, PowerPoint, Canva, or Word SmartArt can significantly improve the quality of the report. This appendix page can either contain smaller versions of the diagrams or provide a list of diagram titles used in the document.

## Page 66. Appendix D: Hardware and Software Requirements

The software requirements for the project include Flutter SDK, Dart SDK, Python environment, Django, Django REST Framework, Firebase project configuration, and machine learning libraries such as pandas, scikit-learn, and joblib. The project can be developed and demonstrated using a standard development machine with browser support for Flutter web testing and adequate memory for local backend and ML scripts.

Suggested hardware requirements may include:

- processor: modern multi-core CPU
- RAM: minimum 8 GB recommended
- storage: sufficient free space for dependencies, project files, and model artifacts
- internet: required for dependency installation and Firebase or optional data setup

Including this page helps complete the project documentation in a professional academic format.

## Page 67. Appendix E: Viva Preparation Points

This appendix page may include short technical talking points useful during project presentation or viva:

- why paper trading is useful for beginners
- why Flutter was selected for the frontend
- why Django and Django REST Framework were selected for the backend
- how Firebase fits into the project
- how average price is recalculated during buy operations
- how the portfolio value is derived
- why machine learning is included and how it currently works
- what limitations still remain
- what future improvements are most important

This appendix is optional in the final report, but it can be very helpful as a preparation aid before external evaluation or internal presentation.

## Page 68. Appendix F: Final Note for Word Formatting

To convert this draft into a final major project report, the following steps should be followed carefully:

1. Replace all placeholder values such as student name, college name, guide name, department, and enrollment number.
2. Insert real screenshots from the project implementation.
3. Add diagrams at the suggested points.
4. Convert the heading structure into the exact report format required by the college.
5. Generate the table of contents, list of figures, and list of tables automatically in Word.
6. Adjust spacing so that each chapter or page marker occupies the intended amount of content.

This file is written as an original, project-specific base document. It should now serve as the foundation for a fuller, polished Word report tailored to institutional submission standards.

