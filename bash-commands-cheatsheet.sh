2> FILE : redirect stderr
2>&1 : redirect the stderr to where the stdin is
	cmd > out.txt 2>&1
&> FILE : redirect stdin and stderr, only in bash version something and above, not portable

files def mode 666
dirs def mode 777
umask default 022

4 <-> r
2 <-> w
1 <-> x

id [OPTIONS]
	-u : effective uid
	-g : effective gid
whoami  : username
echo $USER : username

access time(atime)
change time(ctime) := status change
modification time(mtime) := data modification

chown [-R] OWNER FILE...
chgrp [-R] GROUP FILE...
chmod MODE FILE...

mkdir [OPTIONS] [DIRECTORY] 
	-p : make all parent dirs 
	-m MODE : create with mode
touch FILE..
rm [-r] FILE
cp [-r] SOURCE DESTINATION
mv [-r] SOURCE DESTINATION

ln [OPTIONS] TARGET LINK_NAME		creates a hard link
	-s : make symlinks

echo [OPTIONS] STIRNG
	-e : enable interpretation of backslash escapes, i.e. \n, \t

find [-P|L|H] [START_POINT...] [OPTIONS]... <ACTIONS>
	-L follow symlinks  
	-P do not follow symlinks (default behavior)
	-H do not follow symlinks, unless those on the command line arguments
	
	-daystart : measure times from today, rather than from 24 hrs ago
	-maxdepth N : proccess to level N, maxdepth 0 := only the cmd arguments
	-maxdepth N : proccess from level N and deeper
	
	-{a, c, m}min [+|-]N 
	-{a, c, m}time [+|-]N
	-{a, c, }newer FILE

	-empty : file(regular file or directory) is empty
	-type TYPE : file is type = TYPE = [d, f, l, b, c, s] : d:=directory, f:=regular file, l:=symlink
	-size [+|-]N[c, K, M, G] : size is [more|less] N [in bytes, kilobytes, megabytes, gigabytes]
	
	-name PATTERN		iname PATTERN : same as name but case insensitive
	-user UNAME 				-uid N 
	-group	GRPNAME				-gid N 
	-nouser	: no group corresponds to the file numeric uid
	-nogroup : no group corresponds to the file numeric gid
	-links [+|-]N : file has N hard links
	-inum N : file has inode number N
	-samefile NAME : file refers to the same inode as NAME
	
	-perm PMODE	: mode bits are exactly PMODE
	-perm -PMODE : these bits are set, more are also true, eg perm -664 mathches 777 too
	-perm /PMODE : any of the PMODE bits are set
	
	-readable	-writable	-executable
	
	<actions>
	-exec cmd_name '{}' \;	: {} is a placeholder for the results from find
	-delete
	-printf FORMAT : for each result print the stuff
		%f : only the filename withouth any leading directories
		%p : path from START_POINT
		%d : depth from START_POINT, 0 means the file is a starting point
		%s : size in bytes
		%n : number of hard links
		%i : inode number
		
		%u : owner username or numeric uid if it has no name		%U owner numeric uid
		%g : owner groupname or numeric gid if it has no name		%G owner numberic gid
		%m : modes in octal
		%M : modes in human readable
		
		%y : type of the file(like ls -l)
		%Y : like %y, but follows symlinks, L=loop, N=nonexistent
		%A@ : atime since Epoch
		%C@ : ctime since Epoch
		%T@ : mtime since Epoch
		
stat [OPTIONS] FILE...			information about file or file system
	-L : follow symlinks
	--printf FORMAT
		%n : file name without leading directories
		%s : size in bytes
		%h : number of hard links
		%i : inode number
		
		%u : owner uid					%U : owner username
		%g : owner gid					%G : owner groupname	
		%a : modes in octal
		%A : modes in human readable

		%F : type of the file
		%W : time of file birth since Epoch
		%X : atime since Epoch
		%Z : ctime since Epoch
		%Y : mtime since Epoch
		
grep [OPTIONS] PATTERN [FILE...]		
grep [OPTIONS] -e PATTERN... [FILE...]		
grep [OPTIONS] -f FILE... [FILE...]
	-E : use extended regex (or just call egrep)
	-F : interprets PATTERN as fixed strings instead of regex (or just call fgrep)
	-e PATTERN
	-f FILE : obatain patterns from file, one pattern from each line
	-i : case insensitive matches
	-v : inverts the matching, i.e. prints the non-matching results
	-w : select lines, where matches that form whole words
	-x : select only those matches that exactly match the whole line
	-c : prints the number of matching lines for each input file
	-m NUM : stop reading a file afte NUM matching lines
	-o : prints only the matched (non-empty) parts of a mathching line, with each part on new line
	-q : exit with 0 status if any match is found, does not write to stdout
	-n : prefixes the output with 1-based line number within its input file
	-A NUM : print NUM lines of trailing context after matching lines
	-B NUM : print NUM lines of trailing context before matching lines	
	-C NUM : print NUM lines before and after matching lines
	
sort [OPTIONS] FILE...
	-k KEYDEF : field to sort on, 1...;	
		KEYDEF is F[.C][OPTS],... F:field number, C:charcter position in the field, OPTS:[d|n|r]
	-t SEP : field separator
	-d : dictionary sort
	-n : numeric sort
	-r : reverse sort
	-f : ignore case

uniq [OPTIONS] [INPUT]		<with no options dublicate lines are merged to first occurrence>
	-c : prefix the number of occurrences
	-u : print only the unique lines
	-d : print only the dublicate lines, one for each group

cut OPTION [FILE]...		<print selected parts of lines from each FILE or stdin
	-d DELIM : delimiter
	-f LIST : select only fields in LIST
	-b LIST : select only bytes in LIST
	-c LIST : select only characters in LIST

	--complement : complement the set of selected bytes, chars or fields
	-s : do not print lines not containing delimiters
	--output-delimiter=STRING : use STRING as output delim, default for output delim is the input delim

	only one of -b, -c or -f can be used, LIST can be :
	N : Nth byte, char or field, counted from 1
	N- : from Nth to the end of the line
	N-M : [N-M]
	-M : from the beginning to Mth (included)

tr [OPTIONS] SET1 [SET2]
	-c : use complement of SET1
	-d : delete characters in SET1
	-s : squeeze to single occurrence

head [OPTIONS] FILE...
	-c [-]NUM : print the first NUM bytes, when -NUM print all bytes, except the last NUM bytes
	-n [-]NUM : print the first NUM lines, when -NUM print all lines, except the last NUM lines
	-q : do not print filename headers 

tail [OPTIONS] FILE...
	-c [+]NUM : print the last NUM bytes, when +NUM print all bytes, starting from the NUMth byte
	-n [+]NUM : print the last NUM lines, when +NUM print all lines, starting from the NUMth line
	-q : do not print filename headers 

wc [OPTIONS] FILE
	-l : numeber of newlines
	-w : number of words
	-m : number of characters
	-c : number of bytes

ls [OPTIONS] [FILE]...			non recursively print info about FILEs
	-a : display files starting with .(hidden files)
	-A : hidden files, but without . and ..
	-i : puts the inode number in front
	-l : long listing format; 1drwxrwxrwx 2hard# 3owner 4group 5size 6mtime 7name [8symlink to]
	-d : list info about the directory

xargs -I'{}' cmd '{}' 
bash -c 'cmd1; cmd2; ...'

awk [OPTIONS] 'program text' [FILE]...
	-F SEP : field separator; e.g. : -F ':', -F[:,] : can use multiple separators
	-v VAR=VALUE : assigns VALUE to variable VAR and VAR can be used in the program text
	records (lines, when RS = "\n") and fields :
		$0 : each record(line) is stored here
		$1, $2, ... , $NF
	awk -F[,;] 'expr ~ /regex/ {print $1 " " $2}'
	
sed [OPTIONS] 'script1; script2' [FILE]...
	-E : use extented regex

	sed 's/patt1/patt2/g' : finds and replaces occurrs of patt1 with patt2 on each line	
	sed '/pattern/d' : deletes occurrences of pattern on each line

ps
	-e : select all processes, not only the ones in the current shell
	-u USERLIST : select by username or uid
	-g GRPLIST : select by groupmane or gid
	-p PIDLIST : select by pid
	-t TTYLIST : select by tty

	--sort=SPEC : specify sorting order; [+|-]KEY[,...], + := sort increasing, - := sort decreasing
		i.e. ps -e --sort=-pid
	--no-headers : do not print headers

	-o FORMAT : display the info for each process in format, could be renamed, e.g. ps -u ivo -o "pid=process"
		%cpu : cpu usage in format ##.#
		%mem : memory usage in procents

		args : command with  arguments 
		comm : only the command, without arguments
		rss : consumed RAM in kilobytes
		vsz : consumed virtual memory 
		etimes : elapsed time in seconds since the process started

		pid : process id
		ppid : the pid of the parent process
		pri : priority(niceness), higher numbers mean lower prioirity

		user : display username
		uid : display gid (decimal number)
		group : display groupname
		gid : display gid (decimal number)
		tty : terminal name
pgrep [OPTIONS] PATTERN 			<returs the pids of matched processes>	
	-u UIDLIST : match by uid, multiple can be used
	-g GRPLIST : match by gid, multiple can be used
	-P PPID : match by ppid
	-t TERM : match by tty
	-f : match by whole command line, that started process

	-SIGNAL : sends SIGNAL to each matched process
	-n : returns only the newest matched process
	-o : returns only the oldest matched process
	-l : lists process name as well as pid
	-c : return the number of matched processes
	-d DELIM : use DELIM as output delimiter
	-v : inverse the sense of matching
	-i : case insensitive search


kill [OPTIONS] <PID>...
	kill -15 <pid>
	sleep 2
	kill -9 <pid>

renice  							<change niceness of processes>
	-p : the next elements are pids
	-u : the next elements are uids
	-g : the next elements are pids

	renice +1 987 -u root daemon -p 32 : change niceness to proc with pid 987 and 32 and all proc owned by root and daemon

$0 : name of the script
$1, $2 : the arguments
$# : number of arguments
$@ : all arguments as one string
$? : exit status of last command

read <var>...
	-p PROMPT

unset <varName> 			delete the shell/enviorment variable

test
	<expr1> -eq <expr2>	 = 			<expr1> -ne <expr2>	 !=
	<expr1> -gt <expr2>	 > 			<expr1> -ge <expr2>	 >=  
	<expr1> -lt <expr2>	 <			<expr1> -le <expr2>	 <= 	 
	-n STR : string with non-negative length
	-z STR : string with zero lenth
	str1 = str2 : equality of strings		str1 != str2 : strings are not equal
	str1 == pattern 			str =~ regex

	-e FILE : file exists
	-f FILE : file exists and its regular file
	-d FILE : file exists and its directory
	-h FILE : file exists and its symlink
	-s FILE : file exists and has size > 0

	-r FILE
	-w FILE
	-x FILE

	FILE1 -nt FILE2 : newer that (mtime)
	FILE1 -ot FILE2 : older that (mtime)
	-O FILE : file exists and its owned by the effective uid
	-G FILE : file exists and its owned by the effective gid

	-u FILE : file exists and has set-user-id bit set
	-g FILE : file exists and its set-group-id bit set
	-s FILE : file exists and its sticky bit set


md5sum FILE...
	returns <hash> <FILE>
	
	
	
	
	