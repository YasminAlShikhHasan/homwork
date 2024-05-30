import 'package:api_with_ui/model/model.dart';
import 'package:dio/dio.dart';

abstract class QuestionsService {
  Dio dio = Dio();
  String url = "https://66559eca3c1d3b60293a5a39.mockapi.io/api/v1/questions";
  late Response response;
  Future<bool> createNewQuiz(Questions quize);
  Future<List<Questions>> getallQuestions();
}

class QuestionsServiceImp extends QuestionsService {
  @override
  Future<bool> createNewQuiz(Questions quize) async {
    try {
      response = await dio.post(url, data: quize.toMap());
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print(e.message);
      return false;
    }
  }

  @override
  Future<List<Questions>> getallQuestions() async {
    response = await dio.get(url);
    print(response);
    try {
      if (response.statusCode == 200) {
        List<Questions> questions = List.generate(response.data.length,
            (index) => Questions.fromMap(response.data.index));

        return questions;
      } else {
        return [];
      }
    }  catch (e) {
      print(e);
      return [];
    }
  }
}
