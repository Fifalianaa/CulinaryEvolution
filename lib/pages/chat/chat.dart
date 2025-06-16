import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _showAttachmentMenu = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> _suggestedMessages = [
    "Bonjour",
    "Qu'est ce que culinary evolution",
    "Prendre rendez vous",
    "Merci",
    "Quels sont vos services ?",
    "Puis-je avoir plus d'informations ?",
    "Au revoir",
  ];

  final ScrollController _scrollController = ScrollController();
  late Timer _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _autoScrollTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;
        double nextScroll = currentScroll + 100;

        if (nextScroll >= maxScroll) {
          nextScroll = 0;
        }

        _scrollController.animateTo(
          nextScroll,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _toggleAttachmentMenu() {
    setState(() {
      _showAttachmentMenu = !_showAttachmentMenu;
      if (_showAttachmentMenu) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    final time = TimeOfDay.now().format(context);

    setState(() {
      _messages.add({
        'text': text,
        'isMe': true,
        'time': time,
      });
      _messageController.clear();
    });

    Future.delayed(Duration(milliseconds: 1000), () {
      String userMsg = text.trim().toLowerCase();
      Map<String, dynamic> response;

      if (userMsg == 'bonjour') {
        response = {
          'text':
          "Bonjour, nous sommes Culinary Evolution, comment pouvons-nous vous aider ?",
          'image': 'assets/images/about.png',
          'isMe': false,
          'time': TimeOfDay.now().format(context),
        };
      } else if (userMsg.contains('prendre rendez vous')) {
        response = {
          'text':
          "Nous allons traiter votre demande et vous répondrons dans un instant.",
          'isMe': false,
          'time': TimeOfDay.now().format(context),
        };
      } else if (userMsg.contains('au revoir')) {
        response = {
          'text': "Au plaisir de vous revoir, à bientôt.",
          'isMe': false,
          'time': TimeOfDay.now().format(context),
        };
      } else if (userMsg.contains('merci')) {
        response = {
          'text':
          "Merci à vous. N'hésitez pas à nous contacter en cas d'autres besoins.",
          'isMe': false,
          'time': TimeOfDay.now().format(context),
        };
      } else if (userMsg.contains('quels sont vos services')) {
        response = {
          'text':
          "Nous proposons une variété de services culinaires innovants, allant de la création de recettes personnalisées à la consultation gastronomique. Souhaitez-vous en savoir plus ?",
          'isMe': false,
          'time': TimeOfDay.now().format(context),
        };
      } else if (userMsg.contains('informations')) {
        response = {
          'text':
          "Bien sûr ! Vous pouvez consulter notre site ou nous poser vos questions ici. Nous sommes là pour vous guider selon vos besoins.",
          'isMe': false,
          'time': TimeOfDay.now().format(context),
        };
      } else if (userMsg.contains('culinary evolution')) {
        response = {
          'text':
          "Culinary Evolution est une entreprise spécialisée dans l'innovation culinaire. Nous aidons les professionnels et passionnés à réinventer leur cuisine grâce à notre expertise et nos solutions sur mesure.",
          'isMe': false,
          'time': TimeOfDay.now().format(context),
        };
      } else {
        response = {
          'text':
          "Votre requête a été bien reçue, nous vous contacterons dans un instant.",
          'isMe': false,
          'time': TimeOfDay.now().format(context),
        };
      }

      setState(() {
        _messages.add(response);
      });
    });
  }

  Widget _buildAttachmentMenu() {
    return SizeTransition(
      sizeFactor: _fadeAnimation,
      axisAlignment: -1.0,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.image, color: Colors.orange),
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile =
                await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _messages.add({
                      'image': pickedFile.path,
                      'isMe': true,
                      'time': TimeOfDay.now().format(context),
                    });
                  });
                }
                _toggleAttachmentMenu();
              },
            ),
            IconButton(
              icon: Icon(Icons.attach_file, color: Colors.orange),
              onPressed: _toggleAttachmentMenu,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> msg) {
    final isMe = msg['isMe'] ?? false;
    final bgColor = isMe ? Colors.orange : Colors.grey[200];
    final textColor = isMe ? Colors.white : Colors.black87;
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    final avatarImage = isMe
        ? 'assets/images/africalounge.png'
        : 'assets/images/culinary.png';

    return Row(
      mainAxisAlignment:
      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMe)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ClipOval(
              child: Image.asset(
                avatarImage,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              ),
            ),
          ),
        Flexible(
          child: Column(
            crossAxisAlignment: align,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (msg['text'] != null)
                      Text(
                        msg['text'],
                        style: TextStyle(color: textColor),
                      ),
                    if (msg['image'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Image.asset(
                          msg['image'],
                          width: 150,
                        ),
                      ),
                  ],
                ),
              ),
              Text(
                msg['time'] ?? '',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        if (isMe)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: ClipOval(
              child: Image.asset(
                avatarImage,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSuggestions() {
    return Container(
      height: 48,
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12),
        itemCount: _suggestedMessages.length,
        itemBuilder: (context, index) {
          final suggestion = _suggestedMessages[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => _sendMessage(suggestion),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  suggestion,
                  style: TextStyle(color: Colors.orange.shade900),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _animationController.dispose();
    _scrollController.dispose();
    _autoScrollTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                reverse: true,
                children: _messages.reversed.map(_buildMessage).toList(),
              ),
            ),
            if (_showAttachmentMenu) _buildAttachmentMenu(),
            _buildSuggestions(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      _showAttachmentMenu ? Icons.close : Icons.add,
                      color: Colors.orange,
                    ),
                    onPressed: _toggleAttachmentMenu,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Tapez un message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _sendMessage(_messageController.text),
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
