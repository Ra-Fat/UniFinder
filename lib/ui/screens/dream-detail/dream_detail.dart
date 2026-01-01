import 'package:flutter/material.dart';
import 'dart:math';
import './mock_data.dart';

class DreamDetail extends StatelessWidget {
  final Dream dream;
  final List<UniversityMajor> universityMajors;

  const DreamDetail({
    super.key,
    required this.dream,
    required this.universityMajors,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dream.name,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SectionHeader(
              title: 'Career Opportunities',
              onSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Placeholder()),
                );
              },
            ),

            CareerCardsList(careers: dream.careers),

            const SizedBox(height: 20),

            Text('Primary Major', style: textTheme.labelLarge),
            const SizedBox(height: 10),

            MajorCard(
              major: dream.primaryMajor,
              universityMajors: universityMajors,
            ),

            const SizedBox(height: 20),

            Text('Related Majors', style: textTheme.labelLarge),
            const SizedBox(height: 10),

            RelatedMajorList(
              majors: dream.relatedMajors,
              universityMajors: universityMajors,
            ),
          ],
        ),
      ),
    );
  }
}

class MajorCard extends StatelessWidget {
  final Major major;
  final List<UniversityMajor> universityMajors;

  const MajorCard({
    super.key,
    required this.major,
    required this.universityMajors,
  });

  @override
  Widget build(BuildContext context) {
    final filtered = universityMajors
        .where((universityMajor) => universityMajor.major.id == major.id)
        .toList();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(major.name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            SizedBox(
              height: min(filtered.length * 60.0, 120),
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final universityMajor = filtered[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: UniversityTile(
                      name: universityMajor.university.name,
                      price: universityMajor.tuitionRange,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UniversityTile extends StatelessWidget {
  final String name;
  final String price;
  const UniversityTile({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Placeholder()),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: ListTile(
          dense: true,
          visualDensity: VisualDensity(vertical: -2),
          title: Text(
            name,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            price,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class RelatedMajorList extends StatelessWidget {
  final List<Major> majors;
  final List<UniversityMajor> universityMajors;

  const RelatedMajorList({
    super.key,
    required this.majors,
    required this.universityMajors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: majors
          .map(
            (major) =>
                MajorCard(
                  major: major, 
                  universityMajors: universityMajors
                ),
          )
          .toList(),
    );
  }
}

class CareerCard extends StatelessWidget {
  const CareerCard({super.key, required this.career});

  final Career career;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Placeholder()),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon and Career Name
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.work_outline,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        career.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Description
                SizedBox(
                  height: 36,
                  child: Text(
                    career.shortDescription,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 12),

                // Skills Chips
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: career.skills.take(3).map((skill) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CareerCardsList extends StatelessWidget {
  final List<Career> careers;
  const CareerCardsList({super.key, required this.careers});

  @override
  Widget build(BuildContext context) {
    final displayedCareers = careers.take(3).toList(); // Show 3 cards
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            displayedCareers.length +
            (careers.length > 3
                ? 1
                : 0), // more than 3 career show see all card
        itemBuilder: (context, index) {
          // Last item shows "See All" indicator
          if (index == displayedCareers.length) {
            return SeeAllCard(totalCount: careers.length);
          }
          final career = displayedCareers[index];
          return CareerCard(career: career);
        },
      ),
    );
  }
}

class SeeAllCard extends StatelessWidget {
  final int totalCount;
  const SeeAllCard({super.key, required this.totalCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Placeholder()),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary.withAlpha(204),
                  Theme.of(context).colorScheme.secondary.withAlpha(204),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: 12),
                Text(
                  'See All',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '$totalCount careers',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const SectionHeader({super.key, required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: Text(
            'See All',
            style: textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
