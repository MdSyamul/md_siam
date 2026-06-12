import 'package:flutter/material.dart';

const String siteName = 'Md. Syamul Bashar';
const String siteHeroStatement =
    'Physical AI, intelligent engineering systems, control theory, and reinforcement learning for real-world mechanical applications.';
const String siteHeroSummary =
    'Assistant Professor in the Department of Mechanical Engineering at Shahjalal University of Science and Technology, with research spanning Physical AI, Intelligent Design and Manufacturing, Control Theory and System Dynamics';
const String siteBiography =
    '''I am an Assistant Professor in the Department of Mechanical Engineering at Shahjalal University of Science and Technology. My work sits at the intersection of Physical AI, intelligent design and manufacturing, control systems, reinforcement learning, and computational modeling. I earned my B.Sc. in Mechanical Engineering with Distinction from SUST, and I continue to build applied research in thermal comfort, robotics, smart agriculture, airfoil design, and fluid dynamics.''';

const String profileImagePath = 'assets/siam.jpeg';
const String emailAddress = 'md.syamul-mee@sust.edu';
const String phoneNumber = '+8801307486552';
const String departmentAddress =
    'Department of Mechanical Engineering, Shahjalal University of Science and Technology, Sylhet-3114, Bangladesh';
const String githubUrl = 'https://github.com/MdSyamul';
const String universityProfileUrl =
    'https://www.sust.edu/departments/mee/faculty/md.syamul-mee@sust.edu';
const String googleScholarUrl =
    'https://scholar.google.com/citations?user=6Xqz7xgAAAAJ&hl=en';
const String linkedInUrl =
    'https://www.linkedin.com/in/md-syamul-bashar-9293a8161/';
const String githubRepositoriesUrl =
    'https://github.com/MdSyamul?tab=repositories';

const List<String> heroKeywords = [
  'Physical AI',
  'Intelligent design and manufacturing',
  'Control Theory and System Dynamics',
];

class DetailItem {
  const DetailItem({required this.label, required this.value});

  final String label;
  final String value;
}

class HighlightItem {
  const HighlightItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;
}

class ResearchArea {
  const ResearchArea({
    required this.title,
    required this.summary,
    required this.icon,
    required this.applications,
  });

  final String title;
  final String summary;
  final IconData icon;
  final List<String> applications;
}

class ProjectItem {
  const ProjectItem({
    required this.title,
    required this.year,
    required this.category,
    required this.summary,
    this.note,
  });

  final String title;
  final String year;
  final String category;
  final String summary;
  final String? note;
}

class PublicationItem {
  const PublicationItem({
    required this.title,
    required this.venue,
    required this.year,
    required this.status,
    this.note,
    this.url,
  });

  final String title;
  final String venue;
  final String year;
  final String status;
  final String? note;
  final String? url;
}

class MentoringItem {
  const MentoringItem({
    required this.title,
    required this.status,
    required this.summary,
  });

  final String title;
  final String status;
  final String summary;
}

class RepositoryItem {
  const RepositoryItem({
    required this.repoName,
    required this.title,
    required this.summary,
    required this.language,
    required this.url,
  });

  final String repoName;
  final String title;
  final String summary;
  final String language;
  final String url;
}

class SkillGroup {
  const SkillGroup({
    required this.title,
    required this.summary,
    required this.skills,
  });

  final String title;
  final String summary;
  final List<String> skills;
}

const List<DetailItem> aboutDetails = [
  DetailItem(
    label: 'Current Role',
    value:
        'Assistant Professor, Department of Mechanical Engineering, Shahjalal University of Science and Technology',
  ),
  DetailItem(
    label: 'Education',
    value:
        'B.Sc. in Mechanical Engineering with Distinction, SUST (January 2016 - November 2019)',
  ),
  DetailItem(label: 'Academic Rank', value: 'CGPA 3.78/4.00'),
  DetailItem(
    label: 'Thesis',
    value:
        'Numerical Investigation of Blood Flow through Human Common Carotid Artery',
  ),
  DetailItem(
    label: 'Research',
    value:
        'Physical AI, intelligent design and manufacturing, control theory, system dynamics, reinforcement learning',
  ),
  DetailItem(
    label: 'Tools',
    value: 'PyTorch, TensorFlow, ROS 2, MATLAB, Python, C, ANSYS Fluent',
  ),
];

const List<HighlightItem> heroMetrics = [
  HighlightItem(
    value: '2',
    label: 'Journal publications',
    icon: Icons.auto_stories_rounded,
  ),
  HighlightItem(
    value: '6',
    label: 'Recent conference works',
    icon: Icons.groups_rounded,
  ),
  HighlightItem(
    value: '2',
    label: 'Funded grants',
    icon: Icons.account_balance_wallet_rounded,
  ),
  HighlightItem(
    value: '6',
    label: 'Supervised thesis topics',
    icon: Icons.school_rounded,
  ),
];

const List<HighlightItem> siteHighlights = [
  HighlightItem(
    value: '2021',
    label: 'Joined SUST as Assistant Professor',
    icon: Icons.business_center_rounded,
  ),
  HighlightItem(
    value: '3.78/4.00',
    label: 'B.Sc. CGPA with Distinction',
    icon: Icons.workspace_premium_rounded,
  ),
  // HighlightItem(
  //   value: '2nd',
  //   label: 'Ranked in graduating class',
  //   icon: Icons.emoji_events_rounded,
  // ),
  HighlightItem(
    value: '4 Years',
    label: 'SUST Merit Scholarship recipient',
    icon: Icons.military_tech_rounded,
  ),
  // HighlightItem(
  //   value: '7.5',
  //   label: 'IELTS overall score',
  //   icon: Icons.language_rounded,
  // ),
];

const List<ResearchArea> researchAreas = [
  ResearchArea(
    title: 'Physical AI',
    summary:
        'Building intelligent mechanical systems that sense, decide, and act in the physical world.',
    icon: Icons.smart_toy_rounded,
    applications: [
      'Robot manipulation and skill learning',
      'Autonomous vessels for waste detection and collection',
      'Sensor-driven engineering systems',
    ],
  ),
  ResearchArea(
    title: 'Intelligent Design and Manufacturing',
    summary:
        'Using machine learning and surrogate models to improve engineering design and manufacturing decisions.',
    icon: Icons.precision_manufacturing_rounded,
    applications: [
      'Airfoil inverse design and synthesis',
      'Physics-guided surrogate modeling',
      'Data-driven engineering optimization',
    ],
  ),
  ResearchArea(
    title: 'Control Theory and System Dynamics',
    summary:
        'Modeling dynamic systems and designing control strategies for robust performance in practical environments.',
    icon: Icons.tune_rounded,
    applications: [
      'Thermal comfort control',
      'Lift control in aerodynamic systems',
      'System-level engineering analysis',
    ],
  ),
  // ResearchArea(
  //   title: 'Reinforcement Learning for Engineering Systems',
  //   summary:
  //       'Applying reinforcement learning to mechanical and robotic systems that need adaptive decision making.',
  //   icon: Icons.psychology_alt_rounded,
  //   applications: [
  //     'Thermal comfort setpoint control',
  //     'Lifelong skill acquisition in robotics',
  //     'Adaptive control policies for complex environments',
  //   ],
  // ),
  // ResearchArea(
  //   title: 'Computational Fluid Dynamics',
  //   summary:
  //       'Numerical investigation of flow behavior in biomedical and aerodynamic settings.',
  //   icon: Icons.waves_rounded,
  //   applications: [
  //     'Blood flow through carotid arteries',
  //     'Airfoil aerodynamic performance modeling',
  //     'Reduced-order aerodynamic analysis',
  //   ],
  // ),
];

const List<ProjectItem> projectEntries = [
  ProjectItem(
    title:
        'Integrating Machine Learning with IoT for Smart Indoor Farming Management',
    year: '2023',
    category: 'SUST Funded Grant',
    summary:
        'A smart agriculture project combining IoT and machine learning, including YOLO-based lettuce disease detection for indoor farming.',
    note: 'Approx. USD 3,000 equivalent in local currency.',
  ),
  ProjectItem(
    title:
        'Development of an Autonomous Boat for Floating Solid Waste Detection and Collection from Rivers',
    year: '2022',
    category: 'SUST Funded Grant',
    summary:
        'An applied environmental robotics project focused on detecting floating debris and supporting autonomous river clean-up.',
    note: 'Approx. USD 3,000 equivalent in local currency.',
  ),
  ProjectItem(
    title: 'Sensors and Data Collection for Autonomous Electric Vehicles',
    year: 'Ongoing',
    category: 'Applied Research',
    summary:
        'Developing sensing and data pipelines that support autonomy-oriented vehicle research.',
  ),
  ProjectItem(
    title: 'Thermal Comfort Prediction and Control',
    year: '2025-2026',
    category: 'Intelligent Control',
    summary:
        'Learning-driven thermal comfort prediction and reinforcement learning control using sensor-lite and PMV-based approaches.',
  ),
  ProjectItem(
    title: 'Airfoil Surrogate Modeling and Inverse Design',
    year: '2025-2026',
    category: 'Computational Design',
    summary:
        'Combining datasets, surrogate models, and generative methods to study airfoil performance in incompressible flow.',
  ),
];

const List<PublicationItem> journalPublications = [
  PublicationItem(
    title:
        'CFD analysis of non-Newtonian blood flow through human carotid artery bifurcation: Carotid sinus susceptible to atherosclerosis',
    venue: 'Heliyon',
    year: '2024',
    status: 'Published',
    url: 'https://doi.org/10.1016/j.heliyon.2024.e40286',
  ),
  PublicationItem(
    title:
        'CFD analysis of blood flow through bifurcated carotid artery (of human): Newtonian vs. non-Newtonian blood model',
    venue: 'SUST Journal of Science & Technology',
    year: '2022',
    status: 'Published',
    url: 'https://journals.sust.edu/index.php/sustjst/article/view/27',
  ),
];

const List<PublicationItem> conferencePublications = [
  PublicationItem(
    title:
        'Sensor-Lite Model for Thermal Comfort Prediction Using Contextual Proxy Features',
    venue:
        '15th International Conference on Mechanical Engineering (ICME 2025)',
    year: '2025',
    status: 'Published',
    url: 'https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6204578',
  ),
  PublicationItem(
    title: 'Predicting Globe Temperature: Model Development and Analysis',
    venue:
        '15th International Conference on Mechanical Engineering (ICME 2025)',
    year: '2025',
    status: 'Published',
    url: 'https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6200418',
  ),
  PublicationItem(
    title:
        'Reinforcement Learning for Thermal Comfort Control Using Predicted Mean Vote Setpoints',
    venue:
        'IEEE International Conference on Engineering and Frontier Technologies (ICEFronT 2026)',
    year: '2026',
    status: 'Submitted',
  ),
  PublicationItem(
    title:
        'Physics-Guided Surrogate Modeling for Airfoils\' Aerodynamic Performance in Incompressible Flow Regime',
    venue:
        'IEEE International Conference on Engineering and Frontier Technologies (ICEFronT 2026)',
    year: '2026',
    status: 'Submitted',
  ),
  PublicationItem(
    title:
        'Conditional Generative Inverse Design of Airfoils in the Incompressible Flow Regime',
    venue:
        'International Conference on Emerging Frontiers in Advanced Sciences and Technologies (EFAST 2026)',
    year: '2026',
    status: 'Submitted',
  ),
  PublicationItem(
    title:
        'Goal-Aware Reinforcement Learning Policy for Lifelong Skill Acquisition in Robotic Manipulation',
    venue:
        'International Conference on Emerging Frontiers in Advanced Sciences and Technologies (EFAST 2026)',
    year: '2026',
    status: 'Submitted',
  ),
  PublicationItem(
    title:
        'Proxy Features-based Thermal Comfort Prediction with Minimal Sensor Requirements',
    venue: 'Extended version of published conference work',
    year: 'In Progress',
    status: 'Manuscript Ready',
  ),
  PublicationItem(
    title: 'Adaptive Thermal Comfort Control Using Reinforcement Learning',
    venue: 'Extended version of accepted conference work',
    year: 'In Progress',
    status: 'Manuscript Ready',
  ),
];

const List<String> teachingCourses = [
  'Control Engineering',
  'Numerical Analysis',
  'Fluid Mechanics',
  'Basic Thermodynamics',
];

const List<String> additionalTeachingCourses = [
  'Programming Methodology',
  'Applied Statistics for Engineers',
];

const List<MentoringItem> mentoringItems = [
  MentoringItem(
    title: 'Conditional Airfoil Synthesis Using Generative Models',
    status: 'Ongoing',
    summary:
        'Undergraduate thesis on generative modeling for airfoil synthesis in incompressible flow regimes.',
  ),
  MentoringItem(
    title: 'Adaptive Vision-Language-Action Policies for Robot Manipulation',
    status: 'Ongoing',
    summary:
        'Benchmarking modern VLA policies for variable-DoF robotic manipulation problems.',
  ),
  MentoringItem(
    title:
        'Physics-Guided Reduced-Order Modeling for Stepped-Airfoil Aerodynamics',
    status: 'Ongoing',
    summary:
        'Interpretable reduced-order aerodynamic modeling grounded in physical constraints.',
  ),
  MentoringItem(
    title: 'Reinforcement Learning for Thermal Comfort Control',
    status: 'Completed',
    summary:
        'Thesis work centered on PMV-based thermal comfort control using reinforcement learning.',
  ),
  MentoringItem(
    title: 'Airfoil Dataset and Surrogate Modeling',
    status: 'Completed',
    summary:
        'Dataset creation and data-driven aerodynamic performance modeling for airfoils.',
  ),
  MentoringItem(
    title: 'SLAM Algorithm Performance Analysis Using 2D Lidar and ROS',
    status: 'Completed',
    summary:
        'Comparative performance analysis of localization and mapping algorithms in ROS-based setups.',
  ),
];

const List<RepositoryItem> featuredRepositories = [
  RepositoryItem(
    repoName:
        'Reinforcement-Learning-for-Thermal-Comfort-Control-Using-Predicted-Mean-Vote-Setpoints',
    title: 'Thermal Comfort Control with Reinforcement Learning',
    summary:
        'Repository aligned with your conference work on adaptive thermal comfort control using PMV-driven setpoints.',
    language: 'Jupyter Notebook',
    url:
        'https://github.com/MdSyamul/Reinforcement-Learning-for-Thermal-Comfort-Control-Using-Predicted-Mean-Vote-Setpoints',
  ),
  RepositoryItem(
    repoName: 'Airfoil-Lift-Control-RL',
    title: 'Reinforcement Learning for Airfoil Lift Control',
    summary:
        'Applies learning-based control ideas to aerodynamic lift behavior in engineered systems.',
    language: 'Jupyter Notebook',
    url: 'https://github.com/MdSyamul/Airfoil-Lift-Control-RL',
  ),
  RepositoryItem(
    repoName: 'Dataset-for-Airfoil-Aerodynamics-in-Incompressible-Flow-Regime',
    title: 'Airfoil Aerodynamics Dataset',
    summary:
        'A data resource supporting surrogate modeling and analysis of airfoil performance in incompressible flow.',
    language: 'Python',
    url:
        'https://github.com/MdSyamul/Dataset-for-Airfoil-Aerodynamics-in-Incompressible-Flow-Regime',
  ),
  RepositoryItem(
    repoName: 'Floating-Debris-Detection',
    title: 'Floating Debris Detection',
    summary:
        'A public codebase aligned with the autonomous boat project for detecting floating solid waste.',
    language: 'Jupyter Notebook',
    url: 'https://github.com/MdSyamul/Floating-Debris-Detection',
  ),
  RepositoryItem(
    repoName:
        'Sensor-Lite-Model-for-Thermal-Comfort-Prediction-Using-Contextual-Proxy-Features',
    title: 'Sensor-Lite Thermal Comfort Prediction',
    summary:
        'A streamlined prediction approach that reduces sensing requirements for thermal comfort estimation.',
    language: 'Jupyter Notebook',
    url:
        'https://github.com/MdSyamul/Sensor-Lite-Model-for-Thermal-Comfort-Prediction-Using-Contextual-Proxy-Features',
  ),
  RepositoryItem(
    repoName: 'Lectures-on-Reinforcement-Learning',
    title: 'Lectures on Reinforcement Learning',
    summary:
        'Teaching-oriented materials that can support your academic identity on the site.',
    language: 'Jupyter Notebook',
    url: 'https://github.com/MdSyamul/Lectures-on-Reinforcement-Learning',
  ),
];

const List<SkillGroup> skillGroups = [
  SkillGroup(
    title: 'AI and Learning Systems',
    summary:
        'Methods and frameworks for building data-driven and adaptive engineering systems.',
    skills: [
      'Deep Learning',
      'Reinforcement Learning',
      'PyTorch',
      'TensorFlow',
    ],
  ),
  SkillGroup(
    title: 'Engineering Analysis and Design',
    summary:
        'Simulation, design, and analysis tools that support mechanical engineering research.',
    skills: ['ANSYS Fluent', 'AutoCAD', 'SolidWorks'],
  ),
  SkillGroup(
    title: 'Programming and Systems',
    summary:
        'Programming and systems skills for experiments, robotics, modeling, and cross-platform tools.',
    skills: [
      'Python',
      'C',
      'MATLAB',
      'ROS 2',
      'Cross-platform Application Development',
    ],
  ),
];
