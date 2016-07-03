$number = $ARGV[0];  #参加人数
$part = $ARGV[1];  #同時にプレイする人数

$people[$number] = ();  #それぞれ選ばれた回数を保持する
for(my $i = 0; $i < $#people; $i++){
  $people[$i] = 0;
}

$round = 0;  #周回回数
$index = 0;  #配列の位置
for(my $n = 0; $n < 3; $n++){
  $count = 0;  #追加された人数
  $member = "";
  for(my $i = $index; ;$i++){  #人数s分回す
    # 配列の長さを超えたらindexの位置を配列の最初に戻す
    if($i >= $#people){
      $round++;
      $index = 0;
      $i = $index;
    }
    # この週で選ばれていなかったら$memberに追加
    if($people[$i] == $round){
      $member = $member . ($i+1);
      $people[$i]++;
      $count++;
    }
    # 参加人数を満たしたら終了
    if($count >= $part){
      $index = $i;
      last;
    }
  }
  &reCreateMember($member);
  print $member."\n";
}

sub reCreateMember{
  $str = $_[0];  #引数を置き換える
  @array = ();
  foreach $ch (split //, $str){
    push(@array, $ch);
  }
  print @array[0]."\n";
}