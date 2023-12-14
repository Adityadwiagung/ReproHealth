import 'package:flutter/material.dart';
import 'package:reprohealth_app/models/chat_bot_models.dart';
import 'package:reprohealth_app/models/chatbot/chatbot_history_models.dart';
import 'package:reprohealth_app/services/chatbot_services/chatbot_services.dart';

class ChatbotViewModel extends ChangeNotifier {
  final ChatbotServices chatBotServices = ChatbotServices();
  final TextEditingController _chat = TextEditingController();
  TextEditingController get char => _chat;

  final List<ChatBotUser> _messages = [];
  List<ChatBotUser> get messages => _messages;

  bool isLoading = false;

  @override
  void dispose() {
    _chat.dispose();
    super.dispose();
  }

  TextEditingController get chat => _chat;

  Future<void> handleSendMessage() async {
    _messages.add(
      ChatBotUser(
        text: _chat.text,
        chatBot: ChatBot.user,
      ),
    );
    isLoading = true;

    notifyListeners();

    var input = _chat.text;
    _chat.clear();

    try {
      var response = await chatBotServices.postChatbotServices(messages: input);

      isLoading = false;
      _messages.add(
        ChatBotUser(
          text: response,
          chatBot: ChatBot.bot,
        ),
      );

      notifyListeners();
    } catch (error) {
      print("Error in generateResponse: $error");
    }
  }

  final chatbotHistoryServices = ChatbotServices();
  ChatbotHistoryModels? chatbotHistoryViewModel;
  ChatbotHistoryModels? _chatbotList;
  ChatbotHistoryModels? get chatbotList => _chatbotList;
  List<ResponseDataChatbot>? _data = [];
  List<ResponseDataChatbot>? get data => _data;

  Future<void> getHistoryChatbot() async {
    try {
      chatbotHistoryViewModel =
          await chatbotHistoryServices.getChatbotHistory();
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getSessionId({required String idSession}) async {
    try {
      _chatbotList =
          await chatbotHistoryServices.getSessionId(idSession: idSession);
      _data = _chatbotList?.response ?? [];
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> onRefresh() async {
    getHistoryChatbot();
  }
}
