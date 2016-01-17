# 指定の画像を自動生成するスクリプト
use utf8;
use LWP::UserAgent;
use open ":encoding(utf8)";
use URI::Escape;
use Encode qw/encode decode/;

# URLエンコード
my $encode_text = uri_escape_utf8(decode('cp932', $ARGV[0]));
my $text = $ARGV[0];
my $count = $ARGV[1];
my $width = $ARGV[2];
my $height = $ARGV[3];

#引数チェック
if(!(defined($text))){#引数が無いとき
	print "Usage: create_images.pl [filename] [count] [width] [height]";
	print "\n";
	$text = uri_escape_utf8('sample');
}
if(!(defined($count))){
	$count = 10;
}
if(!(defined($width))){
	$width = 150;
}
if(!(defined($height))){
	$height = 150;
}

#userAgentの生成
$ua = LWP::UserAgent->new;
$ua->agent("Myapp/0.1 ");
# 繰り返しリクエストを送る※送りすぎ注意
for($i = 1; $i <= $count; $i++){
	my $url = 'http://placehold.jp/3d4070/ffffff/'.$width.'x'.$height.'.png?text='.$encode_text.'_'.$i;
	my $req = HTTP::Request->new(GET => $url);
	$req->content_type('image/png');

	# リクエストを投げ、結果をレスポンスに
	my $res = $ua->request($req);

	if ($res->is_success) {;
		my $filename = $text.'_'.$i.'.png';
		open(DATAFILE, ">", $filename) or die("error :$!");
		binmode DATAFILE;
		print DATAFILE $res -> content;
		close(DATAFILE);
		print 'created ->'.$filename."<-\n";
	}
	else {
		print $res->status_line, "\n";
	}
}