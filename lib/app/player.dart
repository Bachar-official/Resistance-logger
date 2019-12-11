class Player{
  String name;
  bool isCommander;
  bool inTeam;
  bool isVoted;

  Player(String name){
    this.name = name;
    isCommander = false;
    inTeam = false;
    isVoted = false;
  }

  String getName(){
    return this.name;
  }

  void setRound(bool commander, bool team, bool vote){
    isCommander = commander;
    inTeam = team;
    isVoted = vote;
  }
}