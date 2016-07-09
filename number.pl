my @hash;  #すでに選ばれたグループに対しては1、選ばれていなければ0

$number = $ARGV[0];  #参加人数
$part = $ARGV[1];  #同時にプレイする人数

$people[$number] = ();  #それぞれ選ばれた回数を保持する
for(my $i = 0; $i < $#people; $i++){
  $people[$i] = 0;
}

$round = 0;  #周回回数
$index = 0;  #配列の位置
for(my $n = 0; $n < 100; $n++){
  print "round".$n."\n";
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
  # print $member."\n";
  # print "\n";
  my $newMember = &reCreateMember($member);
  print "\n";
  # print $newMember."\n";
}

sub reCreateMember{
  $str = $_[0];  #引数を置き換える
  @array = ();
  foreach $ch (split //, $str){
    push(@array, $ch);
  }
  # test code
  # for (my $i=0; $i < $#array+1; $i++){
  #   print $array[$i]."\n";
  # }
  my $newMember = changeCombination(@array);  #選んだメンバーの組み合わせを変える 戻り値はString
  if($newMember eq ""){

  }
  return $newMember;
}

sub changeCombination(@array){
  my $resultMember = "";
  for(my $i=0; $i < $#array+1; $i++){
    for(my $j=0; $j < $#array+1; $j++){
      for(my $k=0; $k < $#array+1; $k++){
        for(my $l=0; $l < $#array+1; $l++){
          if((($i ne $j) and ($i ne $k) and ($i ne $l)) and
            (($j ne $k) and ($j ne $l)) and
            ($k ne $l)){
            #pair1とpair2は同一とする
            $pair1 = $array[$i].$array[$j].$array[$k].$array[$l];
            $pair2 = $array[$k].$array[$l].$array[$i].$array[$j];
            $pair3 = $array[$j].$array[$i].$array[$k].$array[$l];
            $pair4 = $array[$i].$array[$j].$array[$l].$array[$k];
            if(($hash{$pair1} ne 1) and ($hash{$peir2} ne 1) and
              ($hash{$pair3} ne 1) and ($hash{$peir4} ne 1)){
              #test code
              # if($i eq 0 and $j eq 1 and $k eq 2 and $l eq 3){
              #   print "there is 1234";
              # }
              # test code
              # print $pair1;
              $hash{$pair1} = 1;
              $hash{$pair2} = 1;
              $hash{$pair3} = 1;
              $hash{$pair4} = 1;
              $resultMember = $array[$i].$array[$j].$array[$k].$array[$l];
              print "i:".$i." j:".$j." k:".$k." l:".$l."\n";
              print $resultMember."\n";
              return $resultMember;
            }
          }
        }
      }
    }
  }
  return $resultMember;
}