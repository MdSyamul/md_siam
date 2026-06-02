import 'package:flutter/material.dart';

class ResearchContentType {
  const ResearchContentType({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;
  final IconData icon;
}

class ResearchContentItem {
  const ResearchContentItem({
    required this.slug,
    required this.type,
    required this.title,
    required this.summary,
    required this.meta,
    required this.icon,
    required this.details,
    this.url,
  });

  final String slug;
  final ResearchContentType type;
  final String title;
  final String summary;
  final String meta;
  final IconData icon;
  final List<String> details;
  final String? url;

  String get searchableText {
    return [
      type.label,
      title,
      summary,
      meta,
      ...details,
    ].join(' ').toLowerCase();
  }
}

const researchTypeArea = ResearchContentType(
  id: 'area',
  label: 'Area',
  icon: Icons.category_rounded,
);

const researchTypeProject = ResearchContentType(
  id: 'project',
  label: 'Project',
  icon: Icons.engineering_rounded,
);

const researchTypePublication = ResearchContentType(
  id: 'publication',
  label: 'Publication',
  icon: Icons.article_outlined,
);

const List<ResearchContentType> researchTypes = [
  researchTypeArea,
  researchTypeProject,
  researchTypePublication,
];

const List<ResearchContentItem> researchItems = [
  // ResearchContentItem(
  //   slug: 'physical-ai',
  //   type: researchTypeArea,
  //   title: 'Physical AI',
  //   summary:
  //       'Building intelligent mechanical systems that sense, decide, and act in the physical world.',
  //   meta: '3 applications',
  //   icon: Icons.smart_toy_rounded,
  //   details: [
  //     'Robot manipulation and skill learning',
  //     'Autonomous vessels for waste detection and collection',
  //     'Sensor-driven engineering systems',
  //   ],
  // ),
  // ResearchContentItem(
  //   slug: 'intelligent-design-and-manufacturing',
  //   type: researchTypeArea,
  //   title: 'Intelligent Design and Manufacturing',
  //   summary:
  //       'Using machine learning and surrogate models to improve engineering design and manufacturing decisions.',
  //   meta: '3 applications',
  //   icon: Icons.precision_manufacturing_rounded,
  //   details: [
  //     'Airfoil inverse design and synthesis',
  //     'Physics-guided surrogate modeling',
  //     'Data-driven engineering optimization',
  //   ],
  // ),
  // ResearchContentItem(
  //   slug: 'control-theory-and-system-dynamics',
  //   type: researchTypeArea,
  //   title: 'Control Theory and System Dynamics',
  //   summary:
  //       'Modeling dynamic systems and designing control strategies for robust performance in practical environments.',
  //   meta: '3 applications',
  //   icon: Icons.tune_rounded,
  //   details: [
  //     'Thermal comfort control',
  //     'Lift control in aerodynamic systems',
  //     'System-level engineering analysis',
  //   ],
  // ),
  // ResearchContentItem(
  //   slug: 'smart-indoor-farming-management',
  //   type: researchTypeProject,
  //   title:
  //       'Integrating Machine Learning with IoT for Smart Indoor Farming Management',
  //   summary:
  //       'A smart agriculture project combining IoT and machine learning, including YOLO-based lettuce disease detection for indoor farming.',
  //   meta: '2023',
  //   icon: Icons.engineering_rounded,
  //   details: [
  //     'SUST Funded Grant',
  //     'Approx. USD 3,000 equivalent in local currency.',
  //   ],
  // ),
  // ResearchContentItem(
  //   slug: 'autonomous-boat-floating-waste',
  //   type: researchTypeProject,
  //   title:
  //       'Development of an Autonomous Boat for Floating Solid Waste Detection and Collection from Rivers',
  //   summary:
  //       'An applied environmental robotics project focused on detecting floating debris and supporting autonomous river clean-up.',
  //   meta: '2022',
  //   icon: Icons.engineering_rounded,
  //   details: [
  //     'SUST Funded Grant',
  //     'Approx. USD 3,000 equivalent in local currency.',
  //   ],
  // ),
  // ResearchContentItem(
  //   slug: 'autonomous-electric-vehicle-sensors',
  //   type: researchTypeProject,
  //   title: 'Sensors and Data Collection for Autonomous Electric Vehicles',
  //   summary:
  //       'Developing sensing and data pipelines that support autonomy-oriented vehicle research.',
  //   meta: 'Ongoing',
  //   icon: Icons.engineering_rounded,
  //   details: ['Applied Research'],
  // ),
  // ResearchContentItem(
  //   slug: 'thermal-comfort-prediction-and-control',
  //   type: researchTypeProject,
  //   title: 'Thermal Comfort Prediction and Control',
  //   summary:
  //       'Learning-driven thermal comfort prediction and reinforcement learning control using sensor-lite and PMV-based approaches.',
  //   meta: '2025-2026',
  //   icon: Icons.engineering_rounded,
  //   details: ['Intelligent Control'],
  // ),
  // ResearchContentItem(
  //   slug: 'airfoil-surrogate-modeling-and-inverse-design',
  //   type: researchTypeProject,
  //   title: 'Airfoil Surrogate Modeling and Inverse Design',
  //   summary:
  //       'Combining datasets, surrogate models, and generative methods to study airfoil performance in incompressible flow.',
  //   meta: '2025-2026',
  //   icon: Icons.engineering_rounded,
  //   details: ['Computational Design'],
  // ),
  // ResearchContentItem(
  //   slug: 'carotid-artery-bifurcation-cfd',
  //   type: researchTypePublication,
  //   title:
  //       'CFD analysis of non-Newtonian blood flow through human carotid artery bifurcation: Carotid sinus susceptible to atherosclerosis',
  //   summary: 'Heliyon',
  //   meta: '2024',
  //   icon: Icons.article_outlined,
  //   details: ['Published'],
  //   url: 'https://doi.org/10.1016/j.heliyon.2024.e40286',
  // ),
  // ResearchContentItem(
  //   slug: 'carotid-artery-newtonian-vs-non-newtonian',
  //   type: researchTypePublication,
  //   title:
  //       'CFD analysis of blood flow through bifurcated carotid artery (of human): Newtonian vs. non-Newtonian blood model',
  //   summary: 'SUST Journal of Science & Technology',
  //   meta: '2022',
  //   icon: Icons.article_outlined,
  //   details: ['Published'],
  //   url: 'https://journals.sust.edu/index.php/sustjst/article/view/27',
  // ),
  // ResearchContentItem(
  //   slug: 'sensor-lite-thermal-comfort-prediction',
  //   type: researchTypePublication,
  //   title:
  //       'Sensor-Lite Model for Thermal Comfort Prediction Using Contextual Proxy Features',
  //   summary:
  //       '15th International Conference on Mechanical Engineering (ICME 2025)',
  //   meta: '2025',
  //   icon: Icons.article_outlined,
  //   details: ['Published'],
  //   url: 'https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6204578',
  // ),
  // ResearchContentItem(
  //   slug: 'predicting-globe-temperature',
  //   type: researchTypePublication,
  //   title: 'Predicting Globe Temperature: Model Development and Analysis',
  //   summary:
  //       '15th International Conference on Mechanical Engineering (ICME 2025)',
  //   meta: '2025',
  //   icon: Icons.article_outlined,
  //   details: ['Published'],
  //   url: 'https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6200418',
  // ),
  // ResearchContentItem(
  //   slug: 'rl-thermal-comfort-control-pmv-setpoints',
  //   type: researchTypePublication,
  //   title:
  //       'Reinforcement Learning for Thermal Comfort Control Using Predicted Mean Vote Setpoints',
  //   summary:
  //       'IEEE International Conference on Engineering and Frontier Technologies (ICEFronT 2026)',
  //   meta: '2026',
  //   icon: Icons.article_outlined,
  //   details: ['Submitted'],
  // ),
  // ResearchContentItem(
  //   slug: 'physics-guided-airfoil-surrogate-modeling',
  //   type: researchTypePublication,
  //   title:
  //       "Physics-Guided Surrogate Modeling for Airfoils' Aerodynamic Performance in Incompressible Flow Regime",
  //   summary:
  //       'IEEE International Conference on Engineering and Frontier Technologies (ICEFronT 2026)',
  //   meta: '2026',
  //   icon: Icons.article_outlined,
  //   details: ['Submitted'],
  // ),
  // ResearchContentItem(
  //   slug: 'conditional-generative-inverse-airfoil-design',
  //   type: researchTypePublication,
  //   title:
  //       'Conditional Generative Inverse Design of Airfoils in the Incompressible Flow Regime',
  //   summary:
  //       'International Conference on Emerging Frontiers in Advanced Sciences and Technologies (EFAST 2026)',
  //   meta: '2026',
  //   icon: Icons.article_outlined,
  //   details: ['Submitted'],
  // ),
  // ResearchContentItem(
  //   slug: 'goal-aware-rl-robotic-manipulation',
  //   type: researchTypePublication,
  //   title:
  //       'Goal-Aware Reinforcement Learning Policy for Lifelong Skill Acquisition in Robotic Manipulation',
  //   summary:
  //       'International Conference on Emerging Frontiers in Advanced Sciences and Technologies (EFAST 2026)',
  //   meta: '2026',
  //   icon: Icons.article_outlined,
  //   details: ['Submitted'],
  // ),
  // ResearchContentItem(
  //   slug: 'proxy-features-thermal-comfort-prediction',
  //   type: researchTypePublication,
  //   title:
  //       'Proxy Features-based Thermal Comfort Prediction with Minimal Sensor Requirements',
  //   summary: 'Extended version of published conference work',
  //   meta: 'In Progress',
  //   icon: Icons.article_outlined,
  //   details: ['Manuscript Ready'],
  // ),
  // ResearchContentItem(
  //   slug: 'adaptive-thermal-comfort-control-rl',
  //   type: researchTypePublication,
  //   title: 'Adaptive Thermal Comfort Control Using Reinforcement Learning',
  //   summary: 'Extended version of accepted conference work',
  //   meta: 'In Progress',
  //   icon: Icons.article_outlined,
  //   details: ['Manuscript Ready'],
  // ),
];
