import 'dart:io';

//https://rainy-sweater-4ce.notion.site/Desafio-dart-ad1c4165dfd540639d50d4eb5b293c87
void main() {
  var oUsuario = le_assinatura();
  var textos = [];
  textos.add(
      "Num fabulário ainda por encontrar será um dia lida esta fábula: A uma bordadora dum país longínquo foi encomendado pela sua rainha que bordasse, sobre seda ou cetim, entre folhas, uma rosa branca. A bordadora, como era muito jovem, foi procurar por toda a parte aquela rosa branca perfeitíssima, em cuja semelhança bordasse a sua. Mas sucedia que umas rosas eram menos belas do que lhe convinha, e que outras não eram brancas como deviam ser. Gastou dias sobre dias, chorosas horas, buscando a rosa que imitasse com seda, e, como nos países longínquos nunca deixa de haver pena de morte, ela sabia bem que, pelas leis dos contos como este, não podiam deixar de a matar se ela não bordasse a rosa branca. Por fim, não tendo melhor remédio, bordou de memória a rosa que lhe haviam exigido. Depois de a bordar foi compará-la com as rosas brancas que existem realmente nas roseiras. Sucedeu que todas as rosas brancas se pareciam exactamente com a rosa que ela bordara, que cada uma delas era exactamente aquela. Ela levou o trabalho ao palácio e é de supor que casasse com o príncipe. No fabulário, onde vem, esta fábula não traz moralidade. Mesmo porque, na idade de ouro, as fábulas não tinham moralidade nenhuma.");
  textos.add(
      "Voltei-me para ela; Capitu tinha os olhos no chão. Ergueu-os logo, devagar, e ficamos a olhar um para o outro... Confissão de crianças, tu valias bem duas ou três páginas, mas quero ser poupado. Em verdade, não falamos nada; o muro falou por nós. Não nos movemos, as mãos é que se estenderam pouco a pouco, todas quatro, pegando-se, apertando-se, fundindo-se. Não marquei a hora exata daquele gesto. Devia tê-la marcado; sinto a falta de uma nota escrita naquela mesma noite, e que eu poria aqui com os erros de ortografia que trouxesse, mas não traria nenhum, tal era a diferença entre o estudante e o adolescente. Conhecia as regras do escrever, sem suspeitar as do amar; tinha orgias de latim e era virgem de mulheres.");
  textos.add(
      "Senão quando, estando eu ocupado em preparar e apurar a minha invenção, recebi em cheio um golpe de ar; adoeci logo, e não me tratei. Tinha o emplasto no cérebro; trazia comigo a idéia fixa dos doidos e dos fortes. Via-me, ao longe, ascender do chão das turbas, e remontar ao Céu, como uma águia imortal, e não é diante de tão excelso espetáculo que um homem pode sentir a dor que o punge. No outro dia estava pior; tratei-me enfim, mas incompletamente, sem método, nem cuidado, nem persistência; tal foi a origem do mal que me trouxe à eternidade. Sabem já que morri numa sexta-feira, dia aziago, e creio haver provado que foi a minha invenção que me matou. Há demonstrações menos lúcidas e não menos triunfantes. Não era impossível, entretanto, que eu chegasse a galgar o cimo de um século, e a figurar nas folhas públicas, entre macróbios. Tinha saúde e robustez. Suponha-se que, em vez de estar lançando os alicerces de uma invenção farmacêutica, tratava de coligir os elementos de uma instituição política, ou de uma reforma religiosa. Vinha a corrente de ar, que vence em eficácia o cálculo humano, e lá se ia tudo. Assim corre a sorte dos homens.");
  var textosComoStrings =
      textos.map((elemento) => elemento.toString()).toList();
  var textoInfectado = avalia_textos(textosComoStrings, oUsuario);
  print(
      "O texto mais provável de ter sido infectado por COH-PIAH é o texto $textoInfectado");
}

//Esse é o jeito de fazer input no dart
List<double> le_assinatura() {
  print("Bem-vindo ao detector automático de COH-PIAH.");
  print("Informe a assinatura típica de um aluno infectado:");
  print("Tamanho médio da palavra:");
  double wal = double.parse(stdin.readLineSync()!);
  print("Relação Type-Token:");
  double ttr = double.parse(stdin.readLineSync()!);
  print("Razão Hapax Legomana:");
  double hlr = double.parse(stdin.readLineSync()!);
  print("tamanho médio de sentença:");
  double sal = double.parse(stdin.readLineSync()!);
  print("complexidade média da sentença:");
  double sac = double.parse(stdin.readLineSync()!);
  print("tamanho médio de frase:");
  double pal = double.parse(stdin.readLineSync()!);

  return [wal, ttr, hlr, sal, sac, pal];
}

//Input padrão de texto para com a condicional

//Isso é basicamente a transcrição do desafio.
double compara_assinatura(List<double> as_a, List<double> as_b) {
  double somaDiferenca = 0;
  for (var i = 0; i < 6; i++) {
    somaDiferenca += ((as_a[i] - as_b[i]).abs()) / 6;
  }
  return somaDiferenca / as_a.length;
}

//função própria armazenar as funções criadas
List<double> calcula_assinatura(String texto) {
  var sentencas = separa_sentencas(texto);
  var frases = sentencas.expand(separa_frases).toList();
  var palavras = frases.expand(separa_palavras).toList();
  var wal = tamanhoMedioPalavra(palavras);
  var ttr = relacaoTypeToken(palavras);
  var hlr = razaoHapaxLegomana(palavras);
  var sal = tamanhoMedioSentenca(sentencas);
  var sac = complexidadeMediaSentenca(frases, sentencas);
  var pal = tamanhoMedioFrase(frases);

  return [wal, ttr, hlr, sal, sac, pal];
}

int avalia_textos(List<String> textos, List<double> oUsuario) {
  var similaridadeMinima = double.infinity;
  var textoInfectado = 0;

  for (var i = 0; i < textos.length; i++) {
    var assinaturaTexto = calcula_assinatura(textos[i]);
    var similaridade = compara_assinatura(oUsuario, assinaturaTexto);

    if (similaridade < similaridadeMinima) {
      similaridadeMinima = similaridade;
      textoInfectado = i + 1;
    }
  }

  return textoInfectado;
}

//Tamanho médio de palavra é a soma dos tamanhos das palavras dividida pelo número total de palavras.
//Essa ideia do reduce foi fazer ele pegar valor por alor do mapa e ir somando.
double tamanhoMedioPalavra(List<String> palavras) {
  var totalCaracteres =
      palavras.map((palavra) => palavra.length).reduce((a, b) => a + b);
  return totalCaracteres / palavras.length;
}

//Relação Type-Token é o número de palavras diferentes dividido pelo número total de palavras.
double relacaoTypeToken(List<String> palavras) {
  var palavrasUnicas = palavras.toSet().length;
  return palavrasUnicas / palavras.length;
}

//Razão Hapax Legomana é o número de palavras que aparecem uma única vez dividido pelo total de palavras.
double razaoHapaxLegomana(List<String> palavras) {
  var palavrasUnicasUmaVez = n_palavras_unicas(palavras);
  return palavrasUnicasUmaVez / palavras.length;
}

//Tamanho médio de sentença é a soma dos números de caracteres em todas as sentenças dividida pelo número de sentenças
double tamanhoMedioSentenca(List<String> sentencas) {
  var totalCaracteresSentencas =
      sentencas.map((sentenca) => sentenca.length).reduce((a, b) => a + b);
  return totalCaracteresSentencas / sentencas.length;
}

//Complexidade de sentença é o número total de frases divido pelo número de sentenças.
double complexidadeMediaSentenca(List<String> frases, List<String> sentencas) {
  return frases.length / sentencas.length;
}

//Tamanho médio de frase é a soma do número de caracteres em cada frase dividida pelo número de frases no texto
double tamanhoMedioFrase(List<String> frases) {
  var totalCaracteresFrases =
      frases.map((frase) => frase.length).reduce((a, b) => a + b);
  return totalCaracteresFrases / frases.length;
}

//Uso de Regex para filtrar
List<String> separa_sentencas(String texto) {
  var separadores = RegExp(r'[.!?]+');
  return texto
      .split(separadores)
      .where((sentenca) => sentenca.isNotEmpty)
      .toList();
}

List<String> separa_frases(String sentenca) {
  var separadores = RegExp(r'[,:;]+');
  return sentenca
      .split(separadores)
      .where((frase) => frase.isNotEmpty)
      .toList();
}

List<String> separa_palavras(String frase) {
  return frase.split(' ').where((palavra) => palavra.isNotEmpty).toList();
}

//A ideia aqui é fazer um tipo de hashmap.
int n_palavras_unicas(List<String> lista_palavras) {
  var contagem = <String, int>{};
  for (var palavra in lista_palavras) {
    contagem[palavra] =
        contagem.containsKey(palavra) ? contagem[palavra]! + 1 : 1;
  }

  return contagem.values.where((count) => count == 1).length;
}
