import 'package:flutter/material.dart';
import 'package:livestream/core/colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palatte.theme,
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrivacyPolicySection(
              title: 'User Conduct',
              content: '''
                1.1. Respectful Behavior: Users are expected to engage in respectful and courteous behavior towards other users, moderators, and viewers during livestreams. Harassment, hate speech, bullying, or any form of abusive behavior will not be tolerated.
                1.2. Lawful Content: Users must comply with local laws and regulations when creating and streaming content. Any content that is illegal, promotes violence, contains explicit or adult material, infringes upon intellectual property rights, or violates privacy rights is strictly prohibited.
                1.3. User Safety: Users should prioritize their personal safety and the safety of others during livestreams. Any activities that endanger the well-being of individuals, encourage self-harm or harm to others, or involve illegal or unsafe behavior are strictly prohibited.
              ''',
            ),
            PrivacyPolicySection(
              title: 'Age Restrictions',
              content: '''
                2.1. Minimum Age Requirement: Users must be at least 18 years old to create an account and access the Vueflo Live app. This age restriction is in place to comply with legal requirements and ensure the protection of minors.
                2.2. Age Verification: Vueflo Live reserves the right to implement age verification mechanisms to verify the age of users when necessary to enforce the minimum age requirement.
              ''',
            ),
            PrivacyPolicySection(
              title: 'Content Guidelines',
              content: '''
                3.1. Copyrighted Material: Users must not livestream or distribute copyrighted material unless they have the necessary rights or permissions to do so.
                3.2. Nudity and Sexual Content: Livestreams containing explicit or adult content, including nudity, sexual acts, or sexualized behavior, are strictly prohibited.
                3.3. Violence and Harmful Activities: Livestreams that promote or glorify violence, self-harm, or dangerous activities that can cause harm to individuals or animals are strictly prohibited.
                3.4. Illegal Activities: Users must not engage in livestreaming activities that promote or involve illegal activities, such as drug use, theft, hacking, or any form of criminal behavior.
              ''',
            ),
            PrivacyPolicySection(
              title: 'Reporting and Moderation',
              content: '''
                4.1. Reporting Inappropriate Content: Users are encouraged to report any livestreams or content that violates this policy by using the reporting features provided within the Vueflo Live app.
                4.2. Moderation Actions: Vueflo Live reserves the right to review reported content and take appropriate moderation actions, including warnings, content removal, temporary or permanent suspension of accounts, and cooperation with law enforcement authorities when necessary.
              ''',
            ),
            PrivacyPolicySection(
              title: 'User Privacy',
              content: '''
                5.1. Data Collection and Usage: Vueflo Live will collect and process user data in accordance with its privacy policy. Users should familiarize themselves with the privacy policy to understand how their data is collected, stored, and used.
                5.2. Personal Information Protection: Users should not share personal information, such as home addresses, phone numbers, or financial information, during livestreams to protect their privacy and safety.
              ''',
            ),
            PrivacyPolicySection(
              title: 'Enforcement and Policy Review',
              content: '''
                6.1. Policy Compliance: Users found to be in violation of this policy may face penalties, including warnings, temporary or permanent suspension of their accounts, or legal action, depending on the severity of the violation.
                6.2. Policy Updates: Vueflo Live reserves the right to update or modify this policy as needed to adapt to changing circumstances, technological advancements, or legal requirements. Users will be notified of any significant policy changes through appropriate channels.
              ''',
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicySection extends StatelessWidget {
  final String title;
  final String content;

  const PrivacyPolicySection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(content),
        const SizedBox(height: 16),
      ],
    );
  }
}
