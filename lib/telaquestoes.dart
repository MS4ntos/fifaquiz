import 'dart:async';

import 'package:flutter/material.dart';
import 'teladestino.dart'; // Certifique-se de que este arquivo contenha TelaResultado

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class Question {
  final String questionText;
  final List<String> options;
  final List<String> optionImages;
  final String correctAnswer;
  final String imageUrl;

  Question(
    this.questionText,
    this.options,
    this.optionImages,
    this.correctAnswer,
    this.imageUrl,
  );
}

class _QuizPageState extends State<QuizPage> {
  int questionIndex = 0;
  int score = 0;
  bool isAnswered = false;
  bool isCorrect = false;
  Timer? _timer;
  int _remainingTime = 20;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  List<Question> questions = [
    Question(
        '1# Qual foi o país anfitrião da Copa do Mundo de 2018?',
        ['Argentina', 'USA', 'Russia', 'Itália'],
        [
          'https://s2-g1.glbimg.com/HltStE_x0uDT3zv26olHLWeQWLc=/0x0:5692x3795/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2023/M/8/1EHlD7SqmXwvzGEynIeA/angelica-reyes-cs9v06tuit8-unsplash.jpg',
          'https://cdn.dadosmundiais.com/pics/flags3d/USA.png',
          'https://static.poder360.com.br/2022/03/bandeira-russia-848x477.jpg',
          'https://benditacidadania.com.br/wp-content/uploads/2020/12/bandeira-da-italia.jpg'
        ],
        'Russia',
        ''),
    Question(
        '2# Quem é o maior artilheiro da história da Copa do Mundo?',
        ['Van dijk', 'Miroslav klose', 'Neymar jr', 'Kaká'],
        [
          'https://img.a.transfermarkt.technology/portrait/big/139208-1702049837.jpg?lm=1',
          'https://www.onthisday.com/images/people/miroslav-klose.jpg?w=720',
          'https://img.a.transfermarkt.technology/portrait/big/68290-1697056482.png?lm=1',
          'https://img.a.transfermarkt.technology/portrait/big/3366-1683638749.jpg?lm=1'
        ],
        'Miroslav klose',
        ''),
    Question(
      '3# Quais são os dois maiores clubes de futebol da cidade de Milão, na Itália?',
      [
        'Genoa e Inter de Milão',
        'Torino e Juventus',
        'Juventus e AC Milan',
        'AC Milan e Inter de Milão'
      ],
      [
        'https://static.sportytrader.com/betting-tip-thumbnail/prod/182934.webp',
        'https://mediaaceh.co.id/wp-content/uploads/2024/04/Torino-vs-Juventus.webp',
        'https://static.sportytrader.com/betting-tip-thumbnail/prod/193553.webp',
        'https://apostas.gazetaesportiva.com/static/wp/milan-inter-milan-1.webp'
      ],
      'AC Milan e Inter de Milão',
      '',
    ),
    Question(
        '4# Qual clube detém o recorde de mais títulos consecutivos no Campeonato Brasileiro?',
        [
          'Santos',
          'Palmeiras',
          'Sao Paulo',
          'vasco',
        ],
        [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT49TtjsaKXJ7HzdmxuCA9GFpvnYjX9zbhmwGe00jhFCw&s',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoFdmCuKjYExHaWjbzAJQ8ne4XyUdbFknPS47WF_XuTA&s',
          'https://yt3.googleusercontent.com/C8rCyrTuhCFBj7U0Od4-4ISbgp5i7OMfAudqi2h7vgcFOy70J6pSao6qG0YO6p7LpdTqlqbceQ=s900-c-k-c0x00ffffff-no-rj',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSA30Aw4CNmLq0SrkgK5kP8ViRfVsxz8B7kNgYo8dMFFA&s'
        ],
        'Sao Paulo',
        ''),
    Question(
        '5# Qual é o único clube que nunca foi rebaixado para a Série B do Campeonato Brasileiro desde a sua criação?',
        [
          'Palmeiras',
          'Gremio',
          'Sao Paulo',
          'Botafogo',
        ],
        [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoFdmCuKjYExHaWjbzAJQ8ne4XyUdbFknPS47WF_XuTA&s',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSL1DN4Ho94GvbqvXrCIODlVjb5VUSst4rNNPg1Nf6srA&s',
          'https://yt3.googleusercontent.com/C8rCyrTuhCFBj7U0Od4-4ISbgp5i7OMfAudqi2h7vgcFOy70J6pSao6qG0YO6p7LpdTqlqbceQ=s900-c-k-c0x00ffffff-no-rj',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSw_lLn-23uZPQOO9m0shTljG36Sj4U-wHr1buHu42WxQ&s'
        ],
        'Sao Paulo',
        ''),
    Question(
        '6# Qual é o time que possui o maior número de participações na Série A do Campeonato Brasileiro?',
        [
          'Bahia',
          'Flamengo',
          'Santos',
          'Cruzeiro',
        ],
        [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRw8BMi6VF1vRVJHTL534wxddP8VCnK6Vo_lMJXWMgykQ&s',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpgynjp6OcdvDkoln_0QfZc2KzVVRRgLaLOZA8R4t7rw&s',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT49TtjsaKXJ7HzdmxuCA9GFpvnYjX9zbhmwGe00jhFCw&s',
          'https://play-lh.googleusercontent.com/KSYtAoZi9-GPEvYBUkEvy422--IapW-8JLI7DfGeDE5IkXkp3bEILDOG4aqe2uIP7qxA'
        ],
        'Flamengo',
        ''),
    Question(
        '7# Quem é o maior artilheiro da história do Campeonato Brasileiro?',
        [
          'Roberto Dinamite',
          'Romario',
          'Edmundo',
          'Fred',
        ],
        [
          'https://veja.abril.com.br/wp-content/uploads/2023/01/Roberto-Dinamite-do-Vasco-comemorando-gol..jpg.jpg?quality=90&strip=info&w=720&h=440&crop=1',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkvv9mohV0anqK3ch-QcjofTu6csfRTdD_6WxearAzrQ&s',
          'https://upload.wikimedia.org/wikipedia/commons/7/74/EdmundoVasco2008_%28cropped_2%29.jpg',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCYye-CE2TwxmE_PLaLr6b_SpNQJplS4zoltcMMXZ6bg&s'
        ],
        'Roberto Dinamite',
        ''),
    Question(
        '8# Qual é o clube que possui o maior número de títulos do Campeonato Brasileiro?',
        [
          'Internacional',
          'Flamengo',
          'Botafogo',
          'Palmeiras',
        ],
        [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJ3AKfHSrnDtJFhc-XN_1u9R8ziiMUkMuYUSihqCgkBg&s',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpgynjp6OcdvDkoln_0QfZc2KzVVRRgLaLOZA8R4t7rw&s',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSw_lLn-23uZPQOO9m0shTljG36Sj4U-wHr1buHu42WxQ&s',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoFdmCuKjYExHaWjbzAJQ8ne4XyUdbFknPS47WF_XuTA&s'
        ],
        'Palmeiras',
        ''),
    Question(
        '9# Quais são os critérios de desempate adotados pelo Campeonato Brasileiro em caso de igualdade de pontos entre dois ou mais times?',
        [
          'saldo de gols, número de gols marcados, confronto direto,',
          'número de gols marcados,quantidade de cartão,Pênalti',
          'confronto direto, saldo de gols, números de faltas',
          'Penalti, número de gols marcados, confronto direto',
        ],
        [
          'https://a-static.mlcdn.com.br/450x450/letras-em-e-v-a-preto-extra-festas/extrafestas/2437/116d7b41fff92f0a671320d0d0a3b80d.jpeg',
          'https://apotiguar.fbitsstatic.net/img/p/letra-b-para-casa-preto-12-5cm-com-adesivo-primafer-90276/275834-1.jpg?w=700&h=700&v=no-change',
          'https://apotiguar.fbitsstatic.net/img/p/letra-c-para-casa-preto-12-5cm-com-adesivo-primafer-90280/275838-1.jpg?w=700&h=700&v=no-change',
          'https://apotiguar.fbitsstatic.net/img/p/letra-d-para-casa-preto-12-5cm-com-adesivo-primafer-90278/275836-1.jpg?w=800&h=800&v=no-change&qs=ignore'
        ],
        'saldo de gols, número de gols marcados, confronto direto,',
        ''),
    Question(
        '10# Quem é considerado o melhor jogador da última edição do Campeonato Brasileiro?',
        [
          'Calleri',
          'GabiGOL',
          'Paulinho',
          'Suarez',
        ],
        [
          'https://tmssl.akamaized.net/images/foto/galerie/jonathan-calleri-sao-paulo-2023-1695159015-117150.jpg?lm=1695159029',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZDXpmq5IRWmZFuRhcaktQiGoiEqzurtAg5g0NckHL3Q&s',
          'https://conteudo.imguol.com.br/c/esporte/72/2023/11/09/paulinho-do-atletico-mg-celebra-gol-sobre-o-corinthians-em-duelo-do-campeonato-brasileiro-1699573182647_v2_450x600.jpg',
          'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2023/06/52995026633_1a363511b0_o-e1687484938274.jpg?w=1220&h=674&crop=1'
        ],
        'Paulinho',
        ''),
    Question(
        '11# Qual jogador detém o recorde de mais jogos disputados na história do Campeonato Brasileiro (era dos pontos corridos)?',
        [
          'Fabio',
          'Rogerio Ceni',
          'Diego Souza',
          'Ze Roberto',
        ],
        [
          'https://p2.trrsf.com/image/fget/cf/774/0/images.terra.com/2023/11/05/1001933909-fabio-fluminense-cruzeiro-libertadores-2023.jpg',
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Rog%C3%A9rio_Ceni_2008.jpg/200px-Rog%C3%A9rio_Ceni_2008.jpg',
          'https://i.superesportes.com.br/YLOeYjWnQcqw9ji7aMkD7J-fKF4=/1200x1200/smart/imgsapp.mg.superesportes.com.br/app/noticia_126420360808/2023/06/27/3998639/diego-souza-deseja-renovar-com-o-gremio_1_31538.jpg',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQouSaqSFIgSToLrzDmz9WZ5uTYFloydcHJs_BfZ9RUxg&s'
        ],
        'Fabio',
        ''),
    Question(
        '12# Quem foi o artilheiro do Campeonato Brasileiro 2023?',
        [
          'Gabigol',
          'Calleri',
          'Pedro Raul',
          'Hulk',
        ],
        [
          'https://i0.statig.com.br/bancodeimagens/imgalta/0w/w7/4z/0ww74zrj0y5fzwcktjrejhcar.jpg',
          'https://p2.trrsf.com/image/fget/cf/774/0/images.terra.com/2024/02/26/298927763-53552185361d8c96c4408k.jpg',
          'https://lncimg.lance.com.br/cdn-cgi/image/width=1300,height=750,quality=75,background=white,fit=pad/uploads/2024/03/WhatsApp-Image-2024-02-19-at-02.03.36-aspect-ratio-512-320.jpeg',
          'https://i.superesportes.com.br/0oc0lOip0NNLSDDumja0CII1-b8=/1200x1200/smart/imgsapp.mg.superesportes.com.br/app/noticia_126420360808/2022/11/15/3979781/hulk-foi-o-artilheiro-do-atletico-em-2022_1_98349.jpg',
        ],
        'Pedro Raul',
        ''),
    Question(
        '13# Qual equipe foi campeã do Campeonato Brasileiro 2023?',
        [
          'Palmeiras',
          'Flamengo',
          'Atlético Mineiro',
          'São Paulo',
        ],
        [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoFdmCuKjYExHaWjbzAJQ8ne4XyUdbFknPS47WF_XuTA&s',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpgynjp6OcdvDkoln_0QfZc2KzVVRRgLaLOZA8R4t7rw&s',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREkA4EwCF2oYDJ50ToGwgCNIuQ3P14uls2irUxfLUesA&s',
          'https://yt3.googleusercontent.com/C8rCyrTuhCFBj7U0Od4-4ISbgp5i7OMfAudqi2h7vgcFOy70J6pSao6qG0YO6p7LpdTqlqbceQ=s900-c-k-c0x00ffffff-no-rj',
        ],
        'Palmeiras',
        ''),
    Question(
        '14# Quantos times participam da Série A do Campeonato Brasileiro?',
        [
          '18',
          '20',
          '22',
          '24',
        ],
        [
          'https://a-static.mlcdn.com.br/450x450/letras-em-e-v-a-preto-extra-festas/extrafestas/2437/116d7b41fff92f0a671320d0d0a3b80d.jpeg',
          'https://apotiguar.fbitsstatic.net/img/p/letra-b-para-casa-preto-12-5cm-com-adesivo-primafer-90276/275834-1.jpg?w=700&h=700&v=no-change',
          'https://apotiguar.fbitsstatic.net/img/p/letra-c-para-casa-preto-12-5cm-com-adesivo-primafer-90280/275838-1.jpg?w=700&h=700&v=no-change',
          'https://apotiguar.fbitsstatic.net/img/p/letra-d-para-casa-preto-12-5cm-com-adesivo-primafer-90278/275836-1.jpg?w=800&h=800&v=no-change&qs=ignore',
        ],
        '20',
        ''),
    Question(
        '15# Qual técnico foi eleito o melhor do Campeonato Brasileiro 2023?',
        [
          'Abel Ferreira',
          'Dorival Júnior',
          'Jorge Sampaoli',
          'Renato Gaúcho',
        ],
        [
          'https://cdn.oantagonista.com/uploads/2024/05/Abel-Ferreira-e-eleito-13%C2%B0-melhor-tecnico-do-mundo.jpg',
          'https://tmssl.akamaized.net//images/foto/galerie/dorival-junior-brazil-2024-1710930754-132158.jpg',
          'https://conteudo.imguol.com.br/c/esporte/af/2023/04/19/jorge-sampaoli-tecnico-do-flamengo-fez-a-sua-estreia-contra-o-nublense-pela-libertadores-1681955837411_v2_450x600.jpg',
          'https://cdn.oantagonista.com/uploads/2024/02/Renato-Gaucho-expoe-cobranca-o-time-apos-em-empate-do-Gremio-com-o-Sao-Luiz-1024x576.jpeg'
        ],
        'Abel Ferreira',
        ''),
    Question(
        '16# Quantas equipes são rebaixadas para a Série B ao final do Campeonato Brasileiro?',
        [
          '2',
          '3',
          '4',
          '5',
        ],
        [
          'https://a-static.mlcdn.com.br/450x450/letras-em-e-v-a-preto-extra-festas/extrafestas/2437/116d7b41fff92f0a671320d0d0a3b80d.jpeg',
          'https://apotiguar.fbitsstatic.net/img/p/letra-b-para-casa-preto-12-5cm-com-adesivo-primafer-90276/275834-1.jpg?w=700&h=700&v=no-change',
          'https://apotiguar.fbitsstatic.net/img/p/letra-c-para-casa-preto-12-5cm-com-adesivo-primafer-90280/275838-1.jpg?w=700&h=700&v=no-change',
          'https://apotiguar.fbitsstatic.net/img/p/letra-d-para-casa-preto-12-5cm-com-adesivo-primafer-90278/275836-1.jpg?w=800&h=800&v=no-change&qs=ignore'
        ],
        '4',
        ''),
    Question(
        '17# Qual jogador recebeu o prêmio de revelação do Campeonato Brasileiro 2023?',
        [
          'Vitor Roque',
          'Endrick',
          'Matheus França',
          'Marcos Leonardo',
        ],
        [
          'https://i0.statig.com.br/bancodeimagens/80/8n/7u/808n7udveevqaclepntimop9l.jpg',
          'https://conteudo.imguol.com.br/c/esporte/75/2024/05/09/endrick-festejou-seu-gol-contra-o-liverpool-uru-imitando-king-kong-1715300879754_v2_450x450.jpg',
          'https://p2.trrsf.com/image/fget/cf/1200/1200/middle/images.terra.com/2023/07/30/16015439-matheus-franca-flamengo-foto-alexandre-vidal.jpg',
          'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2024/01/marcos-leonardo-gol-benfica-e1705264077535.jpg?w=1200&h=1200&crop=1',
        ],
        'Endrick',
        ''),
    Question(
        '18# Quantas rodadas compõem o Campeonato Brasileiro Série A?',
        [
          '32',
          '34',
          '36',
          '38',
        ],
        [
          'https://a-static.mlcdn.com.br/450x450/letras-em-e-v-a-preto-extra-festas/extrafestas/2437/116d7b41fff92f0a671320d0d0a3b80d.jpeg',
          'https://apotiguar.fbitsstatic.net/img/p/letra-b-para-casa-preto-12-5cm-com-adesivo-primafer-90276/275834-1.jpg?w=700&h=700&v=no-change',
          'https://apotiguar.fbitsstatic.net/img/p/letra-c-para-casa-preto-12-5cm-com-adesivo-primafer-90280/275838-1.jpg?w=700&h=700&v=no-change',
          'https://apotiguar.fbitsstatic.net/img/p/letra-d-para-casa-preto-12-5cm-com-adesivo-primafer-90278/275836-1.jpg?w=800&h=800&v=no-change&qs=ignore',
        ],
        '38',
        ''),
    Question(
        '19# Qual equipe teve a maior média de público no Campeonato Brasileiro 2023?',
        [
          'Flamengo',
          'Corinthians',
          'São Paulo',
          'Vasco da Gama',
        ],
        [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpgynjp6OcdvDkoln_0QfZc2KzVVRRgLaLOZA8R4t7rw&s',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7ePvy08108TW7iQXRx_iGECGPRKTwev6Xn1KxUlnsGw&s',
          'https://yt3.googleusercontent.com/C8rCyrTuhCFBj7U0Od4-4ISbgp5i7OMfAudqi2h7vgcFOy70J6pSao6qG0YO6p7LpdTqlqbceQ=s900-c-k-c0x00ffffff-no-rj',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuk01Mtqlw6CgAw9KUNUVsLklWLMpwRgoiay1RYtficw&s'
        ],
        'Flamengo',
        ''),
    Question(
        '20# Qual jogador foi o líder de assistências no Campeonato Brasileiro 2023?',
        [
          'De Arrascaeta',
          'Gustavo Scarpa',
          'Nacho Fernández',
          'Raphael Veiga',
        ],
        [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC6x_p5NnANhM3P0KUb9ihLGxDt73hpSHkN-XceWV2CA&s',
          'https://tntsports.com.br/__export/1594217639141/sites/esporteinterativo/img/2020/07/08/scarpa.jpg_423682103.jpg',
          'https://versus.com.br/wp-content/uploads/2024/04/EuropaPress_5461927_nacho_fernandez_of_real_madrid_in_action_during_the_spanish_league_liga_ea-EP.jpg',
          'https://conteudo.imguol.com.br/c/esporte/43/2024/01/28/raphael-veiga-em-acao-durante-palmeiras-x-santos-jogo-do-campeonato-paulista-1706479965926_v2_1x1.jpg',
        ],
        'De Arrascaeta',
        ''),
  ];

  // Tempo restante em segundos
  void startTimer() {
    _remainingTime = 20;
    _timer?.cancel(); // Cancela qualquer timer anterior
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        handleTimeout();
      }
    });
  }

  void handleTimeout() {
    setState(() {
      isAnswered = true;
      isCorrect = false; // Considera como resposta incorreta
      if (questionIndex < questions.length - 1) {
        questionIndex++;
        isAnswered = false;
        startTimer(); // Reinicia o cronômetro para a próxima pergunta
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TelaResultado(score, questions.length, resetQuiz),
          ),
        );
      }
    });
  }

  void checkAnswer(String userAnswer) {
    String correctAnswer = questions[questionIndex].correctAnswer;

    setState(() {
      isAnswered = true;
      isCorrect = userAnswer == correctAnswer;
      if (isCorrect) {
        score++;
      }
      _timer?.cancel();
      if (questionIndex < questions.length - 1) {
        questionIndex++;
        isAnswered = false;
        startTimer();
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TelaResultado(score, questions.length, resetQuiz),
          ),
        );
      }
    });
  }

  void resetQuiz() {
    setState(() {
      questionIndex = 0;
      score = 0;
      isAnswered = false;
      isCorrect = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/FIFA.png',
              color: const Color(0x80181616),
              colorBlendMode: BlendMode.modulate,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(flex: 1),
              if (!isAnswered)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    questions[questionIndex].questionText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Color(0xff33c507),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (!isAnswered)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Tempo restante: $_remainingTime segundos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xfff6f214),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (!isAnswered)
                Expanded(
                  flex: 3,
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: List.generate(
                        questions[questionIndex].options.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff1d047a),
                            onPrimary: Color(0xfffee503),
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            minimumSize: Size(double.infinity, 10),
                          ),
                          onPressed: () => checkAnswer(
                              questions[questionIndex].options[index]),
                          child: Row(
                            children: [
                              Image.network(
                                questions[questionIndex].optionImages[index],
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  questions[questionIndex].options[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

