
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const NovaAIXOApp());
}

const Color bg = Color(0xFF080B16);
const Color panel = Color(0xFF12182A);
const Color cyan = Color(0xFF00E5FF);
const Color pink = Color(0xFFFF3D81);
const Color purple = Color(0xFF8B5CF6);

class NovaAIXOApp extends StatelessWidget {
  const NovaAIXOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NovaAI XO',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: cyan,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool arabic = true;
  String mode = 'ai';
  String difficulty = 'medium';

  String tr(String ar, String en) => arabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF101A35), bg, Color(0xFF160C28)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.auto_awesome, color: cyan, size: 28),
                    TextButton(
                      onPressed: () => setState(() => arabic = !arabic),
                      child: Text(
                        arabic ? 'English 🌐' : 'العربية 🌐',
                        style: const TextStyle(color: cyan),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    color: panel,
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: cyan, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: cyan.withOpacity(0.22),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.smart_toy_rounded,
                    size: 70,
                    color: cyan,
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'NovaAI XO',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  tr('تحدّي الذكاء الاصطناعي', 'Challenge the AI'),
                  style: const TextStyle(color: cyan, fontSize: 16),
                ),
                const SizedBox(height: 35),
                _heading(tr('اختار طريقة اللعب', 'Choose game mode')),
                const SizedBox(height: 12),
                _modeCard(
                  'ai',
                  Icons.smart_toy_outlined,
                  tr('ضد الذكاء الاصطناعي', 'Play against AI'),
                  tr('العب ضد الكمبيوتر', 'Challenge the computer'),
                  cyan,
                ),
                const SizedBox(height: 12),
                _modeCard(
                  'friend',
                  Icons.people_alt_outlined,
                  tr('لاعب ضد لاعب', 'Two players'),
                  tr('العب مع صاحبك على نفس الجهاز', 'Play with a friend'),
                  pink,
                ),
                if (mode == 'ai') ...[
                  const SizedBox(height: 28),
                  _heading(tr('مستوى الصعوبة', 'Difficulty')),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _difficultyButton(
                        'easy',
                        tr('سهل', 'Easy'),
                        Colors.greenAccent,
                      ),
                      const SizedBox(width: 8),
                      _difficultyButton(
                        'medium',
                        tr('متوسط', 'Medium'),
                        Colors.orangeAccent,
                      ),
                      const SizedBox(width: 8),
                      _difficultyButton(
                        'hard',
                        tr('صعب', 'Hard'),
                        pink,
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cyan,
                      foregroundColor: bg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GamePage(
                            arabic: arabic,
                            againstAI: mode == 'ai',
                            difficulty: difficulty,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      tr('ابدأ اللعب  ▶', 'START GAME  ▶'),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  tr('لعبة XO • العب في أي وقت بدون إنترنت',
                      'XO Game • Play offline anytime'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _heading(String text) {
    return Align(
      alignment: arabic ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _modeCard(
    String value,
    IconData icon,
    String title,
    String subtitle,
    Color accent,
  ) {
    final selected = mode == value;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => setState(() => mode = value),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: panel,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? accent : Colors.white12,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: accent, size: 32),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              color: selected ? accent : Colors.white30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _difficultyButton(String value, String label, Color color) {
    final selected = difficulty == value;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: () => setState(() => difficulty = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: selected ? color.withOpacity(0.15) : panel,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: selected ? color : Colors.white12,
              width: selected ? 2 : 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: selected ? color : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  final bool arabic;
  final bool againstAI;
  final String difficulty;

  const GamePage({
    super.key,
    required this.arabic,
    required this.againstAI,
    required this.difficulty,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> board = List.filled(9, '');
  String turn = 'X';
  String winner = '';
  bool thinking = false;
  int scoreX = 0;
  int scoreO = 0;
  int draws = 0;

  String tr(String ar, String en) => widget.arabic ? ar : en;

  static const List<List<int>> wins = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  String get result {
    for (final line in wins) {
      if (board[line[0]] != '' &&
          board[line[0]] == board[line[1]] &&
          board[line[1]] == board[line[2]]) {
        return board[line[0]];
      }
    }
    if (!board.contains('')) return 'draw';
    return '';
  }

  void play(int index) {
    if (board[index] != '' || winner != '' || thinking) return;
    if (widget.againstAI && turn == 'O') return;

    setState(() {
      board[index] = turn;
      _checkEnd();
      if (winner == '' && widget.againstAI && turn == 'O') {
        turn = 'X';
      }
      if (winner == '' && widget.againstAI && turn == 'X') {
        thinking = true;
      } else if (winner == '') {
        turn = turn == 'X' ? 'O' : 'X';
      }
    });

    if (widget.againstAI && thinking && winner == '') {
      Future.delayed(const Duration(milliseconds: 450), _aiMove);
    }
  }

  void _checkEnd() {
    final r = result;
    if (r == '') return;
    winner = r;
    if (r == 'X') {
      scoreX++;
    } else if (r == 'O') {
      scoreO++;
    } else {
      draws++;
    }
  }

  void _aiMove() {
    if (!mounted || winner != '') return;
    final available = <int>[
      for (int i = 0; i < board.length; i++)
        if (board[i] == '') i,
    ];
    if (available.isEmpty) {
      setState(() => thinking = false);
      return;
    }

    int move;
    if (widget.difficulty == 'easy') {
      move = available[Random().nextInt(available.length)];
    } else if (widget.difficulty == 'medium') {
      move = _bestSimpleMove(available);
    } else {
      move = _bestHardMove();
    }

    setState(() {
      board[move] = 'O';
      _checkEnd();
      thinking = false;
      if (winner == '') turn = 'X';
    });
  }

  int _bestSimpleMove(List<int> available) {
    for (final mark in ['O', 'X']) {
      for (final i in available) {
        board[i] = mark;
        final won = result == mark;
        board[i] = '';
        if (won) return i;
      }
    }
    if (board[4] == '') return 4;
    final corners = [0, 2, 6, 8].where((i) => board[i] == '').toList();
    if (corners.isNotEmpty) return corners[Random().nextInt(corners.length)];
    return available.first;
  }

  int _bestHardMove() {
    int bestScore = -999;
    int bestMove = -1;
    for (int i = 0; i < 9; i++) {
      if (board[i] != '') continue;
      board[i] = 'O';
      final score = _minimax(false, 0);
      board[i] = '';
      if (score > bestScore) {
        bestScore = score;
        bestMove = i;
      }
    }
    return bestMove == -1 ? board.indexOf('') : bestMove;
  }

  int _minimax(bool maximizing, int depth) {
    final r = result;
    if (r == 'O') return 10 - depth;
    if (r == 'X') return depth - 10;
    if (r == 'draw') return 0;

    if (maximizing) {
      int best = -999;
      for (int i = 0; i < 9; i++) {
        if (board[i] != '') continue;
        board[i] = 'O';
        best = max(best, _minimax(false, depth + 1));
        board[i] = '';
      }
      return best;
    } else {
      int best = 999;
      for (int i = 0; i < 9; i++) {
        if (board[i] != '') continue;
        board[i] = 'X';
        best = min(best, _minimax(true, depth + 1));
        board[i] = '';
      }
      return best;
    }
  }

  void restart() {
    setState(() {
      board = List.filled(9, '');
      turn = 'X';
      winner = '';
      thinking = false;
    });
  }

  void _showVoiceInfo() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: panel,
        title: Text(tr('المحادثة الصوتية', 'Voice chat')),
        content: Text(
          tr(
            'ميزة الصوت غير مفعّلة في النسخة دي. اللعبة تشتغل عادي من غير إنترنت.',
            'Voice chat is not enabled in this version. The game works offline.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr('تمام', 'OK')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final status = winner == 'draw'
        ? tr('تعادل!', 'Draw!')
        : winner == 'X'
            ? tr('اللاعب X كسب!', 'Player X wins!')
            : winner == 'O'
                ? tr('اللاعب O كسب!', 'Player O wins!')
                : thinking
                    ? tr('الذكاء الاصطناعي بيفكر...', 'AI is thinking...')
                    : tr('دور اللاعب ', 'Player turn ') + turn;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        title: const Text(
          'NovaAI XO',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: _showVoiceInfo,
            icon: const Icon(Icons.mic_none, color: cyan),
            tooltip: tr('الصوت', 'Voice'),
          ),
          IconButton(
            onPressed: restart,
            icon: const Icon(Icons.refresh, color: cyan),
            tooltip: tr('إعادة اللعب', 'Restart'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: panel,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: purple.withOpacity(0.7)),
                ),
                child: Column(
                  children: [
                    Text(
                      status,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: winner == 'X'
                            ? cyan
                            : winner == 'O'
                                ? pink
                                : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _score('X', scoreX, cyan),
                        _score('=', draws, Colors.white70),
                        _score('O', scoreO, pink),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 9,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final mark = board[index];
                        final color = mark == 'X' ? cyan : pink;
                        return InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => play(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            decoration: BoxDecoration(
                              color: panel,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: mark == '' ? Colors.white12 : color,
                                width: mark == '' ? 1 : 2,
                              ),
                              boxShadow: mark == ''
                                  ? []
                                  : [
                                      BoxShadow(
                                        color: color.withOpacity(0.15),
                                        blurRadius: 15,
                                      ),
                                    ],
                            ),
                            child: Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 180),
                                child: Text(
                                  mark,
                                  key: ValueKey('$index-$mark'),
                                  style: TextStyle(
                                    fontSize: 55,
                                    fontWeight: FontWeight.w900,
                                    color: color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: restart,
                  icon: const Icon(Icons.replay),
                  label: Text(tr('العب من جديد', 'Play again')),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.againstAI
                    ? tr('أنت X والكمبيوتر O', 'You are X, computer is O')
                    : tr('اللاعب الأول X والثاني O', 'Player one X, player two O'),
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _score(String mark, int score, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            mark,
            style: TextStyle(
              fontSize: 22,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$score',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
