class Career {
  final String id;
  final String name;
  final String shortDescription;
  final String description;
  final String salaryRange;
  final List<String> skills;
  final String majorId;
  final Map<String, String> careerProgression;

  Career({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.salaryRange,
    required this.skills,
    required this.majorId,
    required this.careerProgression,
  });
}

class University {
  final String id;
  final String name;

  University({required this.id, required this.name});
}

class Major {
  final String id;
  final String name;
  final List<String> relatedMajorIds;

  Major({
    required this.id,
    required this.name,
    this.relatedMajorIds = const [],
  });
}

class UniversityMajor {
  final University university;
  final Major major;
  final String tuitionRange;

  UniversityMajor({
    required this.university,
    required this.major,
    required this.tuitionRange,
  });
}

class Dream {
  final String id;
  final String name;
  final Major primaryMajor;

  Dream({required this.id, required this.name, required this.primaryMajor});
}

final csMajor = Major(
  id: 'm1',
  name: 'Computer Science',
  relatedMajorIds: ['m2', 'm3'], // SE and IT
);
final seMajor = Major(
  id: 'm2',
  name: 'Software Engineering',
  relatedMajorIds: ['m1', 'm3'], // CS and IT
);
final itMajor = Major(
  id: 'm3',
  name: 'Information Technology',
  relatedMajorIds: ['m1', 'm2'], // CS and SE
);

final rupp = University(id: 'u1', name: 'RUPP');
final itc = University(id: 'u2', name: 'ITC');
final puc = University(id: 'u3', name: 'PUC');

final universityMajors = [
  UniversityMajor(
    university: rupp,
    major: csMajor,
    tuitionRange: '\$500 – \$1,200 / year',
  ),
  UniversityMajor(
    university: itc,
    major: csMajor,
    tuitionRange: '\$800 – \$1,500 / year',
  ),
  UniversityMajor(
    university: puc,
    major: seMajor,
    tuitionRange: '\$1,200 – \$2,000 / year',
  ),
  UniversityMajor(
    university: rupp,
    major: seMajor,
    tuitionRange: '\$700 – \$1,300 / year',
  ),
  UniversityMajor(
    university: itc,
    major: itMajor,
    tuitionRange: '\$600 – \$1,100 / year',
  ),
  UniversityMajor(
    university: puc,
    major: itMajor,
    tuitionRange: '\$1,000 – \$1,800 / year',
  ),
];

final careers = [
  Career(
    id: 'c1',
    name: 'Software Engineer',
    shortDescription: 'Designs and builds software systems.',
    description:
        'Software Engineers design, develop, test, and maintain software applications and systems. They work on everything from mobile apps to large-scale enterprise systems, collaborating with teams to solve complex problems through code.',
    salaryRange: '\$70,000 - \$150,000 / year',
    skills: ['Programming', 'Problem Solving', 'Algorithms', 'Testing'],
    majorId: 'm1',
    careerProgression: {
      'Entry':
          'Junior Developer - Learn coding practices, fix bugs, implement basic features',
      'Mid':
          'Software Engineer - Design features, mentor juniors, lead small projects',
      'Senior':
          'Senior/Lead Engineer - Architecture decisions, lead teams, strategic planning',
    },
  ),
  Career(
    id: 'c2',
    name: 'Data Scientist',
    shortDescription: 'Analyzes data to extract insights.',
    description:
        'Data Scientists analyze large datasets to extract meaningful insights and patterns. They use statistical methods, machine learning algorithms, and data visualization to help organizations make data-driven decisions.',
    salaryRange: '\$80,000 - \$160,000 / year',
    skills: ['Statistics', 'Machine Learning', 'Python', 'SQL'],
    majorId: 'm1',
    careerProgression: {
      'Entry': 'Data Analyst - Clean data, create reports, basic analysis',
      'Mid':
          'Data Scientist - Build ML models, advanced analytics, communicate insights',
      'Senior':
          'Lead Data Scientist - Strategy, mentor team, drive data initiatives',
    },
  ),
  Career(
    id: 'c6',
    name: 'Mobile App Developer',
    shortDescription: 'Creates mobile applications for iOS and Android.',
    description:
        'Mobile App Developers create applications for smartphones and tablets. They design user interfaces, implement features, optimize performance, and ensure apps work seamlessly across different devices and operating systems.',
    salaryRange: '\$65,000 - \$140,000 / year',
    skills: ['Flutter', 'React Native', 'Mobile UI/UX', 'API Integration'],
    majorId: 'm1',
    careerProgression: {
      'Entry':
          'Junior Mobile Developer - Build UI screens, implement features, fix bugs',
      'Mid':
          'Mobile Developer - Design app architecture, lead features, optimize performance',
      'Senior':
          'Senior Mobile Engineer - Technical leadership, app strategy, cross-platform decisions',
    },
  ),
  Career(
    id: 'c7',
    name: 'AI/ML Engineer',
    shortDescription:
        'Builds artificial intelligence and machine learning systems.',
    description:
        'AI/ML Engineers develop intelligent systems that can learn and make decisions. They design neural networks, train machine learning models, and deploy AI solutions that solve real-world problems.',
    salaryRange: '\$90,000 - \$180,000 / year',
    skills: ['Python', 'TensorFlow', 'Neural Networks', 'Deep Learning'],
    majorId: 'm1',
    careerProgression: {
      'Entry':
          'ML Engineer - Implement models, data preprocessing, basic training',
      'Mid':
          'AI/ML Engineer - Design ML systems, optimize algorithms, deploy at scale',
      'Senior':
          'Lead AI Engineer - Research direction, architecture, strategic AI initiatives',
    },
  ),
  Career(
    id: 'c8',
    name: 'Cybersecurity Analyst',
    shortDescription: 'Protects systems and networks from cyber threats.',
    description:
        'Cybersecurity Analysts protect organizations from cyber attacks and data breaches. They monitor networks, identify vulnerabilities, implement security measures, and respond to security incidents.',
    salaryRange: '\$75,000 - \$145,000 / year',
    skills: [
      'Network Security',
      'Ethical Hacking',
      'Risk Assessment',
      'Incident Response',
    ],
    majorId: 'm1',
    careerProgression: {
      'Entry':
          'Security Analyst - Monitor systems, investigate alerts, document incidents',
      'Mid':
          'Cybersecurity Specialist - Penetration testing, security architecture, risk analysis',
      'Senior':
          'Security Manager - Security strategy, compliance, lead security team',
    },
  ),
  Career(
    id: 'c9',
    name: 'Cloud Engineer',
    shortDescription: 'Designs and manages cloud infrastructure.',
    description:
        'Cloud Engineers build and maintain cloud-based systems and infrastructure. They design scalable solutions, manage cloud resources, and ensure applications run efficiently in cloud environments.',
    salaryRange: '\$85,000 - \$165,000 / year',
    skills: ['AWS', 'Azure', 'Docker', 'Kubernetes', 'DevOps'],
    majorId: 'm1',
    careerProgression: {
      'Entry': 'Cloud Support - Basic deployments, monitoring, troubleshooting',
      'Mid': 'Cloud Engineer - Design infrastructure, automation, optimization',
      'Senior':
          'Cloud Architect - Enterprise solutions, multi-cloud strategy, standards',
    },
  ),
  Career(
    id: 'c10',
    name: 'Game Developer',
    shortDescription: 'Creates video games and interactive experiences.',
    description:
        'Game Developers create engaging video games and interactive entertainment. They program game mechanics, implement graphics, optimize performance, and work with designers to bring game concepts to life.',
    salaryRange: '\$60,000 - \$130,000 / year',
    skills: ['Unity', 'Unreal Engine', 'Game Design', 'C++', '3D Graphics'],
    majorId: 'm1',
    careerProgression: {
      'Entry':
          'Junior Game Programmer - Implement features, bug fixes, tool development',
      'Mid':
          'Game Developer - Design systems, lead features, technical problem solving',
      'Senior':
          'Lead Game Engineer - Architecture, technical direction, team leadership',
    },
  ),
  Career(
    id: 'c3',
    name: 'Full Stack Developer',
    shortDescription: 'Builds complete web applications.',
    description:
        'Full Stack Developers work on both frontend and backend of web applications. They create user interfaces, build APIs, manage databases, and ensure seamless integration between all components.',
    salaryRange: '\$70,000 - \$140,000 / year',
    skills: ['Frontend', 'Backend', 'DevOps', 'Databases', 'APIs'],
    majorId: 'm2',
    careerProgression: {
      'Entry': 'Junior Developer - Build features, learn stack, fix bugs',
      'Mid':
          'Full Stack Developer - Design systems, lead projects, mentor juniors',
      'Senior':
          'Senior Full Stack - Architecture decisions, technical leadership, strategy',
    },
  ),
  Career(
    id: 'c4',
    name: 'UI/UX Designer',
    shortDescription: 'Designs user interfaces and experiences.',
    description:
        'UI/UX Designers create intuitive and beautiful user experiences. They conduct user research, design interfaces, create prototypes, and ensure products are easy and enjoyable to use.',
    salaryRange: '\$65,000 - \$135,000 / year',
    skills: [
      'Creativity',
      'User Research',
      'Figma',
      'Prototyping',
      'Design Systems',
    ],
    majorId: 'm2',
    careerProgression: {
      'Entry':
          'Junior Designer - Create mockups, assist research, design components',
      'Mid':
          'UI/UX Designer - Lead design projects, user research, design systems',
      'Senior':
          'Lead Designer - Design strategy, mentor team, establish standards',
    },
  ),
  Career(
    id: 'c5',
    name: 'IT Support Specialist',
    shortDescription: 'Provides technical support and maintenance.',
    description:
        'IT Support Specialists help users solve technical problems and maintain computer systems. They troubleshoot issues, install software, manage hardware, and ensure technology runs smoothly.',
    salaryRange: '\$45,000 - \$80,000 / year',
    skills: [
      'Troubleshooting',
      'Communication',
      'Networking',
      'Hardware',
      'Customer Service',
    ],
    majorId: 'm3',
    careerProgression: {
      'Entry':
          'Help Desk Technician - Answer tickets, basic troubleshooting, user support',
      'Mid':
          'IT Support Specialist - Complex issues, system administration, training',
      'Senior':
          'IT Manager - Oversee support team, IT strategy, vendor management',
    },
  ),
];

// List of all majors for repository
final allMajors = [csMajor, seMajor, itMajor];

final dream = Dream(id: 'd1', name: 'Childhood Dream', primaryMajor: csMajor);
