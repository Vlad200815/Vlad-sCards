abstract interface class SaveWordsRepositoryInterface {
  //learn
  Future<void> saveLearnWords(Map<String, dynamic> listMap);
  Future<List<Map<String, dynamic>>> getLearnWords();
  Future<void> removeLearnWord(Map<String, dynamic> word);
  //remove learn on the training screen
  Future<void> removeLearn();

  //knew
  Future<void> saveKnewWords(Map<String, dynamic> listMap);
  Future<List<Map<String, dynamic>>> getKnewWords();
  Future<void> removeKnewWord(Map<String, dynamic> word);
}
