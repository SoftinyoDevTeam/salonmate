import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salonmate/core/functions.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'package:dio/dio.dart';

class CanliDestekScreen extends StatefulWidget {
  const CanliDestekScreen({super.key});

  @override
  State<CanliDestekScreen> createState() => _CanliDestekScreenState();
}

class _CanliDestekScreenState extends State<CanliDestekScreen> {
  late WebViewXController webviewController;
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  // OpenAI API key
  final String apiKey =
      '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';
  final Dio _dio = Dio();
  List<Map<String, dynamic>> _conversationHistory = [];

  @override
  void initState() {
    super.initState();
    // Add system prompt to conversation history
    _conversationHistory.add({
      'role': 'system',
      'content':
          'Sen bir salon yönetim uygulaması olan SalonMate\'in AI asistanısın. Adın Mate AI. Amacın kullanıcıların salon yönetimi, sac bakimi ile ilgili sorularına yardımcı olmak. Bunun disindaki konulara mumkun oldugunca kisa cevaplar ver'
    });
  }

  Future<void> _sendMessageToOpenAI(String message) async {
    try {
      _conversationHistory.add({'role': 'user', 'content': message});

      final response = await _dio.post(
        'https://api.openai.com/v1/chat/completions',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
        data: {
          'model': 'gpt-4o-mini',
          'messages': _conversationHistory,
          'temperature': 0.7,
          'max_tokens': 500,
        },
      );

      if (response.statusCode == 200) {
        final aiMessage = response.data['choices'][0]['message']['content'];
        await logMATEAI(message, aiMessage, "gpt-4o-mini");
        // Add assistant response to conversation history
        _conversationHistory.add({'role': 'assistant', 'content': aiMessage});

        // Limit conversation history length to avoid token limits
        if (_conversationHistory.length > 12) {
          // Keep system prompt + last 10 exchanges
          _conversationHistory = [
            _conversationHistory[0], // Keep system prompt
            ..._conversationHistory.sublist(_conversationHistory.length - 10)
          ];
        }

        setState(() {
          _isLoading = false;
          _messages.add(
            ChatMessage(
              text: aiMessage,
              isUser: false,
            ),
          );
        });
      } else {
        throw Exception('API yanıt vermedi');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _messages.add(
          ChatMessage(
            text:
                'Üzgünüm, bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.',
            isUser: false,
          ),
        );
      });
      debugPrint('Error calling OpenAI API: $e');
    }

    // Scroll to bottom after getting response
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUser: true,
        ),
      );
      _isLoading = true;
    });

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // Send message to OpenAI
    _sendMessageToOpenAI(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mate AI',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? _buildWelcomeScreen()
                : ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(15.w),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) => _messages[index],
                  ),
          ),
          if (_isLoading)
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SizedBox(
                    height: 20.w,
                    width: 20.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Text(
                    'Mate düşünüyor...',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          const Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => setState(() {}),
                    keyboardType: TextInputType.text,
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Mesajınızı yazın...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      suffixIcon: IconButton(
                        icon:
                            Icon(Icons.keyboard_hide, color: Colors.grey[600]),
                        onPressed: () => FocusScope.of(context).unfocus(),
                      ),
                    ),
                    minLines: 1,
                    maxLines: 5,
                    onSubmitted: _isLoading ? null : _handleSubmitted,
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: _isLoading || _textController.text.trim().isEmpty
                      ? null
                      : () => _handleSubmitted(_textController.text),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: _isLoading || _textController.text.trim().isEmpty
                          ? Colors.grey[300]
                          : Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 22.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.robot,
              size: 80.w, color: Theme.of(context).primaryColor),
          SizedBox(height: 20.h),
          Text(
            'Mate AI Asistanı',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              'Sorularınızı sorun, Mate AI size yardımcı olacaktır.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({
    Key? key,
    required this.text,
    required this.isUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              backgroundImage: NetworkImage('https://salonmate.co/favicon.ico'),
            ),
            SizedBox(width: 10.w),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue[100] : Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          if (isUser) ...[
            SizedBox(width: 10.w),
            CircleAvatar(
              backgroundColor: Colors.blue[400],
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
