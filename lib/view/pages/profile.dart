import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inspired_senior_care_app/view/widget/bottom_app_bar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MainBottomAppBar(),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            title: const Text('Inspired Senior Care'),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: ListView(
          shrinkWrap: true,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: NamePlate(),
            ),
            Badges(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ProgressSection(),
            )
          ],
        ),
      ),
    );
  }
}

class ProgressSection extends StatelessWidget {
  const ProgressSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Your Progress',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ProgressCategory(
                  title: 'Communication',
                  progressColor: Colors.deepOrange,
                  progress: 100,
                  message: 'All Done. Good Job!'),
              ProgressCategory(
                  title: 'Positive Interactions',
                  progressColor: Colors.redAccent,
                  progress: 33,
                  message: '8 more to go.'),
              ProgressCategory(
                  title: 'Supportive Environment',
                  progressColor: Colors.lightGreen,
                  progress: 70,
                  message: 'Only 3 More!'),
              ProgressCategory(
                  title: 'Brain Change',
                  progressColor: Colors.lightGreen,
                  progress: 40,
                  message: 'Only 3 More!'),
              ProgressCategory(
                  title: 'Damaging Interactions',
                  progressColor: Colors.grey,
                  progress: 10,
                  message: 'Only 3 More!'),
              ProgressCategory(
                  title: 'Genuine Relationships',
                  progressColor: Colors.red,
                  progress: 70,
                  message: 'Only 3 More!'),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressCategory extends StatelessWidget {
  final String title;
  Color progressColor;
  int progress;
  String message;
  ProgressCategory({
    Key? key,
    required this.title,
    required this.progressColor,
    required this.progress,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                progress == 100
                    ? Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 5,
                        children: [
                          Text(
                            '${progress.toString()}%',
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.lightBlueAccent,
                            size: 14,
                          ),
                        ],
                      )
                    : Text(
                        '${progress.toString()}%',
                      ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(525),
                child: LinearProgressIndicator(
                  minHeight: 12,
                  value: progress / 100,
                  backgroundColor: Colors.grey.shade300,
                  color: progressColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  message,
                  textAlign: TextAlign.right,
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}

class NamePlate extends StatelessWidget {
  const NamePlate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 70,
      leading: const CircleAvatar(
        radius: 30,
        child: Text(
          'RS',
          style: TextStyle(fontSize: 24),
        ),
      ),
      title: Text(
        'Rebecca Simpson',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: const Text('Nurse'),
    );
  }
}

class Badges extends StatelessWidget {
  const Badges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 5,
              children: const [
                Icon(
                  FontAwesomeIcons.star,
                  size: 28,
                ),
                Text('New Member')
              ],
            ),
            const VerticalDivider(
              indent: 20,
              endIndent: 20,
            ),
            Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 5,
              children: const [
                Icon(
                  FontAwesomeIcons.fire,
                  color: Colors.deepOrangeAccent,
                  size: 28,
                ),
                Text('On Fire!')
              ],
            ),
            const VerticalDivider(
              indent: 20,
              endIndent: 20,
            ),
            Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 5,
              children: [
                Icon(
                  FontAwesomeIcons.medal,
                  color: Colors.grey.shade400,
                  size: 28,
                ),
                Text(
                  'Earn More!',
                  style: TextStyle(color: Colors.grey.shade400),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
