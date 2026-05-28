# Personal Website Plan for Md. Syamul Bashar

Prepared on May 1, 2026 using:
- Local Flutter/Dart project in this workspace
- Local assets `assets/siam.jpeg` and `assets/CV_MdSyamul (1).pdf`
- SUST faculty profile
- Public GitHub profile and repositories

## 1. Website Goal

Build a clean, modern academic website in Dart with Flutter Web that:
- presents you as an Assistant Professor at Shahjalal University of Science and Technology,
- highlights your research identity in control engineering, reinforcement learning, robotics, and CFD,
- supports teaching visibility,
- showcases selected GitHub projects,
- and makes it easy for students and collaborators to contact you.

## 2. Recommended Positioning

Primary identity:
- Assistant Professor, Department of Mechanical Engineering, SUST

Core message:
- Mechanical engineering researcher and educator working at the intersection of Physical AI, intelligent design and manufacturing, control systems, reinforcement learning, and computational modeling.

Tone:
- academic,
- confident,
- approachable,
- technically serious without feeling cold.

## 3. Visual Direction

Use a visual style that feels more "modern research lab" than "generic portfolio."

Recommended palette:
- Deep navy: for headers, buttons, and anchors
- Warm wood/tan: inspired by the portrait background for accents
- Soft ivory/off-white: main background
- Muted cyan/steel blue: for data, links, and hover states

Recommended typography:
- Headings: `Merriweather` or `Bitter`
- Body/UI: `IBM Plex Sans` or `Source Sans 3`

Image direction:
- Use `assets/siam.jpeg` in the hero section with a cropped portrait treatment
- Add a subtle warm overlay or framed card so the image feels intentional on desktop and mobile

## 4. Recommended Site Structure

This should be a polished single-page website with anchored navigation.

### A. Hero

Content:
- Name: Md. Syamul Bashar
- Title: Assistant Professor, Department of Mechanical Engineering
- Institution: Shahjalal University of Science and Technology
- One-line research statement
- Quick credibility highlights:
  - B.Sc. in Mechanical Engineering with Distinction
  - CGPA 3.78/4.00
  - Ranked 2nd in class
- Primary buttons:
  - View Research
  - Teaching
  - Download CV
  - Contact

CV button behavior:
- link directly to `assets/CV_MdSyamul (1).pdf`
- for cleaner deployment, consider renaming it later to `assets/cv_md_syamul_bashar.pdf`

Suggested hero copy:
"I work on Physical AI, intelligent engineering systems, control theory, and reinforcement learning for real-world mechanical applications."

### B. About

Content to include:
- short biography based on the SUST profile
- B.Sc. in Mechanical Engineering with Distinction from SUST
- January 2016 to November 2019
- CGPA 3.78/4.00 and ranked 2nd in class
- thesis title: Numerical Investigation of Blood Flow through Human Common Carotid Artery
- joined the department in 2021
- emphasis on research, teaching, and applied engineering impact

Purpose:
- make the site readable for students, collaborators, and external visitors in under 30 seconds

### C. CV Highlights

Add a compact credentials band or card group under the About section.

Recommended highlights:
- Assistant Professor at SUST since 2021
- B.Sc. with Distinction, CGPA 3.78/4.00
- Ranked 2nd in class
- SUST Merit Scholarship in 2016, 2017, 2018, and 2019
- IELTS 7.5

### D. Research Areas

Use 5 research cards to reflect both the CV and current project direction:
- Physical AI
- Intelligent Design and Manufacturing
- Control Theory and System Dynamics
- Reinforcement Learning for Engineering Systems
- Computational Fluid Dynamics

Each card should have:
- 1 short description
- 2 to 3 example applications

### E. Active Projects and Grants

Use a project/timeline section for current academic work.

Projects and grants confirmed by the CV and SUST profile:
- Integrating Machine Learning with IoT for Smart Indoor Farming Management
- Development of an Autonomous Boat for Floating Solid Waste Detection and Collection from Rivers
- Sensors and data collection for autonomous electric vehicles
- Thermal comfort prediction and control research
- Airfoil surrogate modeling and inverse design research

Recommended presentation:
- show grants as featured cards with title, year, funding source, and 1-line objective
- show research threads as a timeline or grid below the grants

Grant details available from the CV:
- Smart Indoor Farming Management, funded by SUST in 2023, approximately 3,000 USD in local currency
- Autonomous Boat for Floating Solid Waste Detection and Collection, funded by SUST in 2022, approximately 3,000 USD in local currency

### F. Publications

The CV now provides enough material for a real publications section rather than a placeholder.

Recommended UI:
- split into Journal Publications and Conference Publications
- use year badges, venue labels, and external links where available
- add a small status badge such as `Published`, `Accepted`, `Submitted`, or `Manuscript Ready`

Journal publications from the CV:
- CFD analysis of non-Newtonian blood flow through human carotid artery bifurcation: Carotid sinus susceptible to atherosclerosis. Heliyon, 2024.
- CFD analysis of blood flow through bifurcated carotid artery (of human): Newtonian vs. non-Newtonian blood model. SUST Journal of Science & Technology, 2022.

Conference and recent work from the CV:
- Sensor-Lite Model for Thermal Comfort Prediction Using Contextual Proxy Features, ICME 2025
- Predicting Globe Temperature: Model Development and Analysis, ICME 2025
- Reinforcement Learning for Thermal Comfort Control Using Predicted Mean Vote Setpoints, ICEFronT 2026, submitted
- Physics-Guided Surrogate Modeling for Airfoils' Aerodynamic Performance in Incompressible Flow Regime, ICEFronT 2026, submitted
- Conditional Generative Inverse Design of Airfoils in the Incompressible Flow Regime, EFAST 2026, submitted
- Goal-Aware Reinforcement Learning Policy for Lifelong Skill Acquisition in Robotic Manipulation, EFAST 2026, submitted

### G. Teaching

Use a structured teaching section with course chips or grouped cards.

Courses confirmed by the CV:
- Programming Methodology
- Control Engineering
- Numerical Analysis
- Applied Statistics
- Fluid Mechanics
- Instrumentation and Measurements

Secondary courses from the SUST profile that can be added if you want a broader teaching history:
- Engineering Mechanics
- Heat Transfer
- Basic Thermodynamics
- Applied Statistics for Engineers
- Programming Methodologies for Mechanical Engineering
- Production Planning and Control

Possible extras:
- office hours
- course resources
- lecture notes links

### H. Mentoring and Supervision

The CV gives enough material for a mentoring section, which is a strong addition for an academic website.

Recommended content:
- Ongoing undergraduate thesis supervision
- Completed undergraduate mentoring topics

Suggested featured items:
- Conditional Airfoil Synthesis Using Generative Models in the Incompressible Flow Regime
- Adaptive Vision-Language-Action Policies for Variable-DoF Robot Manipulation
- Interpretable and Physics-Guided Reduced-Order Modeling for Stepped-Airfoil Aerodynamics
- Reinforcement Learning for Thermal Comfort Control Using Predicted Mean Vote Setpoints
- Airfoil dataset and surrogate modeling work
- SLAM algorithm performance analysis using 2D lidar with ROS

### I. Featured GitHub Work

This section should not try to show every repository. Curate 4 to 6.

Best candidates based on your public repositories as of May 1, 2026:
- `Reinforcement-Learning-for-Thermal-Comfort-Control-Using-Predicted-Mean-Vote-Setpoints`
- `Airfoil-Lift-Control-RL`
- `Dataset-for-Airfoil-Aerodynamics-in-Incompressible-Flow-Regime`
- `Floating-Debris-Detection`
- `Sensor-Lite-Model-for-Thermal-Comfort-Prediction-Using-Contextual-Proxy-Features`
- `Lectures-on-Reinforcement-Learning`

Secondary repositories that can appear in a "More Work" grid:
- `Globe-Temperature-Prediction`
- `Airfoil-Gen`
- `Airfoil-Aerodynamic-Performance-Surrogate-Model-in-Incompressible-Flow-Regime-`
- `Lettuce-Disease-Detection`
- `Lectures-on-Python`

Recommended presentation for each card:
- repository name,
- short human-readable title,
- 1 sentence summary,
- language badge,
- GitHub link.

### J. Skills and Tools

Add a compact technical skills section or footer strip using the CV.

Recommended content:
- Deep Learning
- Reinforcement Learning
- PyTorch
- TensorFlow
- Python
- C
- MATLAB
- ROS 2
- Ansys Fluent
- AutoCAD
- SolidWorks
- Cross-platform application development

### K. Contact

Include:
- Department of Mechanical Engineering, Shahjalal University of Science and Technology, Sylhet-3114, Bangladesh
- `md.syamul-mee@sust.edu`
- `+8801307486552` if you want phone shown publicly
- GitHub profile
- Google Scholar link
- CV download

Optional:
- research collaboration message
- contact form only if you really need it; otherwise direct email is simpler

## 5. Recommended Navigation

Top navigation:
- Home
- About
- Highlights
- Research
- Publications
- Teaching
- Mentoring
- Projects
- Skills
- Contact

On mobile:
- compact top bar with drawer or sheet menu

## 6. Technical Plan in Dart/Flutter

Recommended implementation approach:
- Flutter Web
- single-page layout with smooth scroll to anchored sections
- responsive desktop/tablet/mobile breakpoints
- section widgets stored separately for maintainability

Suggested app structure:
- `lib/main.dart`
- `lib/app/site_app.dart`
- `lib/data/site_content.dart`
- `lib/models/cv_highlight.dart`
- `lib/models/research_area.dart`
- `lib/models/project_item.dart`
- `lib/models/publication_item.dart`
- `lib/models/mentoring_item.dart`
- `lib/sections/hero_section.dart`
- `lib/sections/about_section.dart`
- `lib/sections/highlights_section.dart`
- `lib/sections/research_section.dart`
- `lib/sections/publications_section.dart`
- `lib/sections/teaching_section.dart`
- `lib/sections/mentoring_section.dart`
- `lib/sections/projects_section.dart`
- `lib/sections/skills_section.dart`
- `lib/sections/contact_section.dart`
- `lib/widgets/section_title.dart`
- `lib/widgets/responsive_container.dart`

State management:
- no heavy state management needed
- static content model objects are enough for version 1

Animation:
- small entrance animations for section reveals
- gentle hover effects on cards
- avoid overly flashy movement

Accessibility:
- high contrast text
- keyboard-focusable nav items
- alt/semantic labels for profile image and action buttons
- clear labels for CV download and external publication links

CV asset handling:
- register `assets/CV_MdSyamul (1).pdf` in `pubspec.yaml`
- expose the file as a direct web asset for download/open
- consider renaming the asset later to remove spaces and parentheses

## 7. Content You Still Need to Provide

Still helpful to provide:
- exact Google Scholar URL so the site links to the correct profile
- optional social links such as LinkedIn, ResearchGate, or ORCID
- whether the public phone number from the CV should appear on the website
- short personal statement if you want the tone to be more personal than institutional
- preferred publication ordering if you want to separate published, submitted, and manuscript-ready work more explicitly

Current local assets status:
- found: `assets/siam.jpeg`
- found: `assets/CV_MdSyamul (1).pdf`

## 8. Build Roadmap

Phase 1:
- replace the starter Flutter screen with the single-page site shell
- register image and CV assets in `pubspec.yaml`
- add your photo, hero, about, and contact sections
- wire the CV download button to the local PDF asset

Phase 2:
- add research, teaching, publications, mentoring, and featured GitHub work
- move content into typed Dart model lists

Phase 3:
- refine spacing, typography, color system, responsiveness, and section hierarchy
- add lightweight animation and section navigation polish

Phase 4:
- deploy the Flutter web build
- connect CV download and final external links

## 9. Important Notes for This Repository

- The current `lib/main.dart` is still a starter template and contains syntax errors, so it should be replaced rather than incrementally edited.
- The workspace is a Flutter project already, which is a good fit for a Dart-based personal website.
- The CV file is now available locally, so the website can ship with a working CV button from version 1.
- The current PDF filename includes spaces and parentheses, which works locally but is worth simplifying before deployment.

## 10. Suggested First Version Scope

For version 1, build only:
- hero,
- about,
- highlights,
- research,
- publications,
- teaching,
- mentoring,
- featured projects,
- skills,
- contact,
- working CV download.

The CV already supplies enough content to launch a solid first version without placeholder publication text.

## 11. Source References

- Local CV:
  - `assets/CV_MdSyamul (1).pdf`
- SUST faculty profile:
  - https://www.sust.edu/departments/mee/faculty/md.syamul-mee@sust.edu
- GitHub profile:
  - https://github.com/MdSyamul
- GitHub repositories:
  - https://github.com/MdSyamul?tab=repositories
