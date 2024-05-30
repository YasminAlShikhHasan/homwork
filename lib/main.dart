import 'package:api_with_ui/core/shared.dart';
import 'package:api_with_ui/model/model.dart';
import 'package:api_with_ui/service/service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Answers(),
    );
  }
}

class CreateQuiz extends StatelessWidget {
  CreateQuiz({super.key});
  TextEditingController question = TextEditingController();
  TextEditingController answer1 = TextEditingController();
  TextEditingController answer2 = TextEditingController();
  TextEditingController answer3 = TextEditingController();
  TextEditingController answer4 = TextEditingController();
  TextEditingController correct = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: 281,
              child: TextField(
                controller: question,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffffffff),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 240,
              child: TextField(
                controller: answer1,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 240,
              child: TextField(
                controller: answer2,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 240,
              child: TextField(
                controller: answer3,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 240,
              child: TextField(
                controller: answer4,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 240,
              child: TextField(
                controller: correct,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: InkWell(
          onTap: () async {
            bool status = await QuestionsServiceImp().createNewQuiz(Questions(
                question: question.text,
                answer: [
                  answer1.text,
                  answer2.text,
                  answer3.text,
                  answer4.text
                ],
                numberofcorrect: int.parse(correct.text)));
            if (status) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("success"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Error"),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: const Icon(Icons.send)),
    );
  }
}

class FirstBage extends StatelessWidget {
  FirstBage({super.key});
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        SizedBox(
          width: 250,
          child: TextField(
            controller: name,
            onChanged: (value) {
              core.get<SharedPreferences>().setString('user', value);
            },
            decoration: InputDecoration(
                hintText: "enter your name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: const Color(0xffDA8BD9)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Score()));
            },
            child: Container(
              width: 287,
              height: 59,
              color: const Color(0xffF3BD6B),
              child: const Center(child: Text("log in")),
            ),
          ),
        )
      ]),
    );
  }
}

class Score extends StatelessWidget {
  const Score({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: 175,
            height: 175,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000), color: Colors.pink),
            child: const Text(
              "your score",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 20),
            ),
          ),
        ),
        Container(
          width: 305,
          height: 159,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(children: [
              Text(core.get<SharedPreferences>().getString('user')!),
              Row(
                children: [
                  Text("the number of correct answer is:"),
                  Text("number")
                ],
              ),
              Row(
                children: [Text("the number of filled:"), Text("number")],
              )
            ]),
          ),
        )
      ]),
    );
  }
}

class Answers extends StatefulWidget {
  const Answers({super.key});

  @override
  State<Answers> createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: QuestionsServiceImp().getallQuestions(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Questions> questions = snapshot.data as List<Questions>;
              List result = questions;
              print(result);
              return Container(
                width: 600,
                height: 900,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          value: isChecked,
                          onChanged: (val) {
                            setState(() {
                              isChecked != val;
                            });
                          },
                          title: Text(snapshot.data![index].answer[index]),
                        );
                      }),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
