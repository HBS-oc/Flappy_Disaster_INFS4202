import 'package:flutter/material.dart';

import 'game.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  String selectedDifficulity = 'Easy';
  String selectedSkin = 'Default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Default.png',
                width: 160,
                height: 120,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.none,
              ),
              SizedBox(height: 40),
              Text(
                'Flappy Disaster',
                style: TextStyle(
                  fontFamily: 'Pix',
                  fontSize: 20,
                  color: Colors.amber,
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 300,
                color: const Color.fromARGB(255, 239, 229, 192),
                child: TextField(
                  controller: nameController,
                  style: TextStyle(fontFamily: 'Pix'),
                  decoration: InputDecoration(
                    labelText: 'Player Name',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontFamily: 'Pix'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 300,
                color: const Color.fromARGB(255, 233, 222, 183),
                alignment: Alignment.center,
                child: DropdownButton<String>(
                  value: selectedDifficulity,
                  items: [
                    DropdownMenuItem(
                      value: 'Easy',
                      child: Text('Difficulity: Easy', style: TextStyle(fontFamily: 'Pix', fontSize: 13)),
                    ),
                    DropdownMenuItem(
                      value: 'Medium',
                      child: Text(
                        'Difficulity: Medium',
                        style: TextStyle(fontFamily: 'Pix', fontSize: 13),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Hard',
                      child: Text('Difficulity: Hard', style: TextStyle(fontFamily: 'Pix', fontSize: 13)),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDifficulity = newValue!;
                    });
                  },
                ),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(300, 60),
                  backgroundColor: const Color.fromARGB(255, 225, 213, 171),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => GameScreen(
                        difficulity: selectedDifficulity,
                        selectedSkin: selectedSkin,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Play',
                  style: TextStyle(fontFamily: 'Pix', color: Colors.black, fontSize: 23),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100, 80),
                      backgroundColor: const Color.fromARGB(255, 232, 224, 166),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'Select Skin',
                                style: TextStyle(fontFamily: 'Pix'),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    child: ListTile(
                                      title: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            'assets/Default.png',
                                            width: 80,
                                            height: 60,
                                            fit: BoxFit.fill,
                                            filterQuality: FilterQuality.none,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Default Bird',
                                            style: TextStyle(
                                              fontFamily: 'Pix',
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          selectedSkin = "Default";
                                        });
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: ListTile(
                                      title: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            'assets/Red.png',
                                            width: 80,
                                            height: 60,
                                            fit: BoxFit.fill,
                                            filterQuality: FilterQuality.none,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Red Bird',
                                            style: TextStyle(
                                              fontFamily: 'Pix',
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          selectedSkin = "Red";
                                        });
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: ListTile(
                                      title: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            'assets/Green.png',
                                            width: 80,
                                            height: 60,
                                            fit: BoxFit.fill,
                                            filterQuality: FilterQuality.none,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Green Bird',
                                            style: TextStyle(
                                              fontFamily: 'Pix',
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          selectedSkin = "Green";
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    child: ListTile(
                                      title: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            'assets/Orange.png',
                                            width: 80,
                                            height: 60,
                                            fit: BoxFit.fill,
                                            filterQuality: FilterQuality.none,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Orange Bird',
                                            style: TextStyle(
                                              fontFamily: 'Pix',
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          selectedSkin = "Orange";
                                        });
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: ListTile(
                                      title: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            'assets/Blue.png',
                                            width: 80,
                                            height: 60,
                                            fit: BoxFit.fill,
                                            filterQuality: FilterQuality.none,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Blue Bird',
                                            style: TextStyle(
                                              fontFamily: 'Pix',
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          selectedSkin = "Blue";
                                        });
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: ListTile(
                                      title: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            'assets/Gold.png',
                                            width: 80,
                                            height: 60,
                                            fit: BoxFit.fill,
                                            filterQuality: FilterQuality.none,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Gold Bird',
                                            style: TextStyle(
                                              fontFamily: 'Pix',
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          selectedSkin = "Gold";
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          );
                        },
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/${selectedSkin}.png', width: 40, height: 30, fit: BoxFit.fill, filterQuality: FilterQuality.none,),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100, 80),
                      backgroundColor: const Color.fromARGB(255, 228, 207, 124),
                    ),
                    child: Image.asset('assets/Achievements.png', width: 40, height: 40, fit: BoxFit.fill, filterQuality: FilterQuality.none,)
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100, 80),
                      backgroundColor: const Color.fromARGB(255, 233, 168, 39),
                    ),
                    child: Image.asset('assets/Leaderboards.png', width: 50, height: 50, fit: BoxFit.fill, filterQuality: FilterQuality.none,)
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
