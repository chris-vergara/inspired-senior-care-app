import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inspired_senior_care_app/bloc/invite/invite_bloc.dart';
import 'package:inspired_senior_care_app/view/widget/bottom_app_bar.dart';
import 'package:inspired_senior_care_app/view/widget/name_plate.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController inviteTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MainBottomAppBar(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(title: const Text('Inspired Senior Care')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: NamePlate(
                memberName: 'Jennifer Sample',
                memberTitle: 'Director',
              ),
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Currently Featured Category:',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Card(
                  elevation: 1.5,
                  child: ListTile(
                    title: const Text('Supportive Environment'),
                    subtitle: const Text('Creating a healthy environment.'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    leading: SizedBox(
                      height: 100,
                      child:
                          Image.asset('lib/assets/Supportive_Environment.png'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 2.0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Your Group',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Wrap(
                    runAlignment: WrapAlignment.end,
                    alignment: WrapAlignment.end,
                    spacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightGreen,
                            onPrimary: Colors.white,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      actionsPadding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      alignment: AlignmentDirectional.center,
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      title: const Text(
                                        'Add a Member',
                                        textAlign: TextAlign.center,
                                      ),
                                      content: const Text(
                                        'Enter their email to send an invite!',
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        Center(
                                          child: FractionallySizedBox(
                                            widthFactor: 0.9,
                                            child: TextField(
                                              autofocus: true,
                                              controller:
                                                  inviteTextFieldController,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                hintText: 'example@email.com',
                                                suffixIcon: BlocBuilder<
                                                    InviteBloc, InviteState>(
                                                  builder: (context, state) {
                                                    if (state.inviteStatus ==
                                                        InviteStatus.sending) {
                                                      return const CircularProgressIndicator();
                                                    }
                                                    if (state.inviteStatus ==
                                                        InviteStatus.sent) {
                                                      return const Icon(
                                                        Icons.check,
                                                        color: Colors.lime,
                                                      );
                                                    }
                                                    return Container(
                                                      width: 1,
                                                    );
                                                  },
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Center(
                                          child: ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.lightGreen,
                                                  fixedSize:
                                                      const Size(250, 40)),
                                              onPressed: () {
                                                context
                                                    .read<InviteBloc>()
                                                    .add(InviteSent());
                                              },
                                              icon: BlocConsumer<InviteBloc,
                                                  InviteState>(
                                                listenWhen:
                                                    (previous, current) =>
                                                        previous.inviteStatus !=
                                                        current.inviteStatus,
                                                listener: (context, state) {
                                                  if (state.inviteStatus ==
                                                      InviteStatus.initial) {
                                                    inviteTextFieldController
                                                        .clear();
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                builder: (context, state) {
                                                  if (state.inviteStatus ==
                                                      InviteStatus.sending) {
                                                    return const CircularProgressIndicator();
                                                  }
                                                  if (state.inviteStatus ==
                                                      InviteStatus.sent) {
                                                    return const Icon(
                                                      Icons.check,
                                                      color: Colors.lime,
                                                    );
                                                  } else {
                                                    return const Icon(
                                                      Icons.send,
                                                      size: 18,
                                                    );
                                                  }
                                                },
                                              ),
                                              label: BlocBuilder<InviteBloc,
                                                  InviteState>(
                                                builder: (context, state) {
                                                  if (state.inviteStatus ==
                                                      InviteStatus.sending) {
                                                    return const Text(
                                                        'Sending...');
                                                  }
                                                  if (state.inviteStatus ==
                                                      InviteStatus.sent) {
                                                    return const Text(
                                                        'Invite Sent!');
                                                  } else {
                                                    return const Text(
                                                        'Send Invite');
                                                  }
                                                },
                                              )),
                                        ),
                                      ],
                                    ));
                          },
                          icon: const Icon(
                            Icons.add_circle_rounded,
                            size: 18,
                          ),
                          label: const Text(
                            'Add Member',
                          )),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent,
                            onPrimary: Colors.white,
                          ),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            size: 18,
                          ),
                          label: const Text(
                            'Edit',
                          )),
                    ],
                  ),
                  GroupMemberTile(
                    memberName: 'Julia Test',
                    memberTitle: 'Nurse',
                    memberProgress: 0.3,
                    memberColor: Colors.pink,
                  ),
                  GroupMemberTile(
                    memberName: 'Amanda Sample',
                    memberTitle: 'Nurse',
                    memberProgress: 0.7,
                    memberColor: Colors.indigo,
                  ),
                  GroupMemberTile(
                    memberName: 'Tracy Chapman',
                    memberTitle: 'Nurse',
                    memberProgress: 0.9,
                    memberColor: Colors.amber,
                  ),
                  GroupMemberTile(
                    memberName: 'George Costanza',
                    memberTitle: 'Nurse',
                    memberProgress: 0.6,
                    memberColor: Colors.cyanAccent,
                  ),
                  GroupMemberTile(
                    memberName: 'Ralph Maccio',
                    memberTitle: 'Nurse',
                    memberProgress: 0.2,
                    memberColor: Colors.brown,
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GroupMemberTile extends StatelessWidget {
  final String memberName;
  final Color memberColor;
  final String memberTitle;
  final double memberProgress;
  final Random random = Random();
  GroupMemberTile({
    Key? key,
    required this.memberName,
    required this.memberTitle,
    required this.memberProgress,
    required this.memberColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color randomColor = Color.fromRGBO(
        random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
    String getInitials(String name) => name.isNotEmpty
        ? name.trim().split(' ').map((l) => l[0]).take(2).join()
        : '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                onTap: () => context.goNamed('view-member'),
                dense: true,
                minLeadingWidth: 50,
                minVerticalPadding: 12.0,
                leading: CircleAvatar(
                  backgroundColor: randomColor,
                  radius: 24.0,
                  child: Text(
                    getInitials(memberName),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                title: Text(
                  memberName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(memberTitle),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.grey.shade300,
                          color: Colors.blueAccent,
                          value: memberProgress,
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: const SizedBox(
                  height: 50,
                  child: Icon(Icons.chevron_right_rounded),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
