; ModuleID = 'atm.c'
source_filename = "atm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.customer = type { [50 x i8], [50 x i8], i32 }

@t = dso_local global i64 0, align 8
@.str = private unnamed_addr constant [14 x i8] c"usernames.txt\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@.str.2 = private unnamed_addr constant [43 x i8] c"Enter choice for the task you want to do: \00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.4 = private unnamed_addr constant [6 x i8] c"clear\00", align 1
@.str.5 = private unnamed_addr constant [18 x i8] c"\09\09 ATM SYSTEM \09\09\0A\00", align 1
@.str.6 = private unnamed_addr constant [19 x i8] c"1: Create Account\0A\00", align 1
@.str.7 = private unnamed_addr constant [18 x i8] c"2: Cash_Withdraw\0A\00", align 1
@.str.8 = private unnamed_addr constant [17 x i8] c"3: Cash_Deposit\0A\00", align 1
@.str.9 = private unnamed_addr constant [20 x i8] c"4: Account Summary\0A\00", align 1
@.str.10 = private unnamed_addr constant [18 x i8] c"5: Check Balance\0A\00", align 1
@.str.11 = private unnamed_addr constant [9 x i8] c"6: Exit\0A\00", align 1
@.str.12 = private unnamed_addr constant [17 x i8] c"Enter Username: \00", align 1
@.str.13 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.str.14 = private unnamed_addr constant [17 x i8] c"Enter Password: \00", align 1
@.str.15 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.16 = private unnamed_addr constant [15 x i8] c"./Names/%s.txt\00", align 1
@.str.17 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.18 = private unnamed_addr constant [61 x i8] c"Enter the amount that you want to save in your new account: \00", align 1
@.str.19 = private unnamed_addr constant [59 x i8] c"Amount Deposited when account was made: %d TimeStamp: %s \0A\00", align 1
@.str.20 = private unnamed_addr constant [50 x i8] c"Username already exists!!! Enter a new Username.\0A\00", align 1
@.str.21 = private unnamed_addr constant [3 x i8] c"r+\00", align 1
@.str.22 = private unnamed_addr constant [50 x i8] c"Enter amount less than your balance to withdraw: \00", align 1
@.str.23 = private unnamed_addr constant [34 x i8] c"You withdrawed: %d TimeStamp: %s\0A\00", align 1
@.str.24 = private unnamed_addr constant [21 x i8] c"User does not exist!\00", align 1
@.str.25 = private unnamed_addr constant [55 x i8] c"Enter Amount to deposit. It should be multiple of 10: \00", align 1
@.str.26 = private unnamed_addr constant [33 x i8] c"You deposited: %d TimeStamp: %s\0A\00", align 1
@.str.27 = private unnamed_addr constant [19 x i8] c"\09\09Account Summary\0A\00", align 1
@.str.28 = private unnamed_addr constant [5 x i8] c"\09\09%s\00", align 1
@.str.29 = private unnamed_addr constant [42 x i8] c"User does not exist or Password is wrong\0A\00", align 1
@stdin = external global ptr, align 8
@.str.30 = private unnamed_addr constant [20 x i8] c"Your Balance is: %d\00", align 1
@.str.31 = private unnamed_addr constant [42 x i8] c"User does not exist or Password is wrong!\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %names_list = alloca ptr, align 8
  %choice = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %call = call i64 @time(ptr noundef @t) #5
  store ptr null, ptr %names_list, align 8
  %call1 = call noalias ptr @fopen(ptr noundef @.str, ptr noundef @.str.1)
  store ptr %call1, ptr %names_list, align 8
  %0 = load ptr, ptr %names_list, align 8
  %call2 = call i32 @fclose(ptr noundef %0)
  br label %while.body

while.body:                                       ; preds = %entry, %sw.epilog
  call void @display()
  store i32 0, ptr %choice, align 4
  %call3 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  %call4 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.3, ptr noundef %choice)
  %1 = load i32, ptr %choice, align 4
  switch i32 %1, label %sw.epilog [
    i32 1, label %sw.bb
    i32 2, label %sw.bb5
    i32 3, label %sw.bb6
    i32 4, label %sw.bb7
    i32 5, label %sw.bb8
    i32 6, label %sw.bb10
  ]

sw.bb:                                            ; preds = %while.body
  call void @create_account()
  br label %sw.epilog

sw.bb5:                                           ; preds = %while.body
  call void @cash_withdraw()
  br label %sw.epilog

sw.bb6:                                           ; preds = %while.body
  call void @cash_deposit()
  br label %sw.epilog

sw.bb7:                                           ; preds = %while.body
  call void @account_summary()
  br label %sw.epilog

sw.bb8:                                           ; preds = %while.body
  %call9 = call i32 @check_balance()
  br label %sw.epilog

sw.bb10:                                          ; preds = %while.body
  call void @exit(i32 noundef 0) #6
  unreachable

sw.epilog:                                        ; preds = %while.body, %sw.bb8, %sw.bb7, %sw.bb6, %sw.bb5, %sw.bb
  br label %while.body
}

; Function Attrs: nounwind
declare i64 @time(ptr noundef) #1

declare noalias ptr @fopen(ptr noundef, ptr noundef) #2

declare i32 @fclose(ptr noundef) #2

; Function Attrs: noinline nounwind uwtable
define dso_local void @display() #0 {
entry:
  %call = call i32 @system(ptr noundef @.str.4)
  %call1 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  %call2 = call i32 (ptr, ...) @printf(ptr noundef @.str.6)
  %call3 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  %call4 = call i32 (ptr, ...) @printf(ptr noundef @.str.8)
  %call5 = call i32 (ptr, ...) @printf(ptr noundef @.str.9)
  %call6 = call i32 (ptr, ...) @printf(ptr noundef @.str.10)
  %call7 = call i32 (ptr, ...) @printf(ptr noundef @.str.11)
  ret void
}

declare i32 @printf(ptr noundef, ...) #2

declare i32 @__isoc99_scanf(ptr noundef, ...) #2

; Function Attrs: noinline nounwind uwtable
define dso_local void @create_account() #0 {
entry:
  %a = alloca %struct.customer, align 4
  %b = alloca %struct.customer, align 4
  %temp = alloca [100 x i8], align 16
  %found = alloca i8, align 1
  %names_list = alloca ptr, align 8
  %new = alloca ptr, align 8
  store i8 70, ptr %found, align 1
  store ptr null, ptr %names_list, align 8
  store ptr null, ptr %new, align 8
  br label %while.body

while.body:                                       ; preds = %entry, %if.end42
  store i8 70, ptr %found, align 1
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str.12)
  %username = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 0
  %arraydecay = getelementptr inbounds [50 x i8], ptr %username, i64 0, i64 0
  %call1 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.13, ptr noundef %arraydecay)
  %call2 = call i32 (ptr, ...) @printf(ptr noundef @.str.14)
  %password = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 1
  %arraydecay3 = getelementptr inbounds [50 x i8], ptr %password, i64 0, i64 0
  %call4 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.13, ptr noundef %arraydecay3)
  %call5 = call noalias ptr @fopen(ptr noundef @.str, ptr noundef @.str.15)
  store ptr %call5, ptr %names_list, align 8
  br label %while.body7

while.body7:                                      ; preds = %while.body, %if.end16
  %0 = load ptr, ptr %names_list, align 8
  %call8 = call i64 @fread(ptr noundef %b, i64 noundef 104, i64 noundef 1, ptr noundef %0)
  %cmp = icmp eq i64 %call8, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %while.body7
  br label %while.end

if.end:                                           ; preds = %while.body7
  %username9 = getelementptr inbounds nuw %struct.customer, ptr %b, i32 0, i32 0
  %arraydecay10 = getelementptr inbounds [50 x i8], ptr %username9, i64 0, i64 0
  %username11 = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 0
  %arraydecay12 = getelementptr inbounds [50 x i8], ptr %username11, i64 0, i64 0
  %call13 = call i32 @strcmp(ptr noundef %arraydecay10, ptr noundef %arraydecay12) #7
  %cmp14 = icmp eq i32 %call13, 0
  br i1 %cmp14, label %if.then15, label %if.end16

if.then15:                                        ; preds = %if.end
  store i8 84, ptr %found, align 1
  br label %while.end

if.end16:                                         ; preds = %if.end
  br label %while.body7

while.end:                                        ; preds = %if.then15, %if.then
  %1 = load ptr, ptr %names_list, align 8
  %call17 = call i32 @fclose(ptr noundef %1)
  %2 = load i8, ptr %found, align 1
  %conv = sext i8 %2 to i32
  %cmp18 = icmp eq i32 %conv, 70
  br i1 %cmp18, label %if.then20, label %if.else

if.then20:                                        ; preds = %while.end
  %call21 = call noalias ptr @fopen(ptr noundef @.str, ptr noundef @.str.1)
  store ptr %call21, ptr %names_list, align 8
  %arraydecay22 = getelementptr inbounds [100 x i8], ptr %temp, i64 0, i64 0
  %username23 = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 0
  %arraydecay24 = getelementptr inbounds [50 x i8], ptr %username23, i64 0, i64 0
  %call25 = call i32 (ptr, ptr, ...) @sprintf(ptr noundef %arraydecay22, ptr noundef @.str.16, ptr noundef %arraydecay24) #5
  %arraydecay26 = getelementptr inbounds [100 x i8], ptr %temp, i64 0, i64 0
  %call27 = call noalias ptr @fopen(ptr noundef %arraydecay26, ptr noundef @.str.17)
  store ptr %call27, ptr %new, align 8
  %call28 = call i32 (ptr, ...) @printf(ptr noundef @.str.18)
  %balance = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 2
  %call29 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.3, ptr noundef %balance)
  %3 = load ptr, ptr %new, align 8
  %balance30 = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 2
  %4 = load i32, ptr %balance30, align 4
  %call31 = call ptr @ctime(ptr noundef @t) #5
  %call32 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %3, ptr noundef @.str.19, i32 noundef %4, ptr noundef %call31) #5
  %5 = load ptr, ptr %names_list, align 8
  %call33 = call i64 @fwrite(ptr noundef %a, i64 noundef 104, i64 noundef 1, ptr noundef %5)
  %6 = load ptr, ptr %new, align 8
  %call34 = call i32 @fclose(ptr noundef %6)
  %7 = load ptr, ptr %names_list, align 8
  %call35 = call i32 @fclose(ptr noundef %7)
  br label %while.end43

if.else:                                          ; preds = %while.end
  %8 = load i8, ptr %found, align 1
  %conv36 = sext i8 %8 to i32
  %cmp37 = icmp eq i32 %conv36, 84
  br i1 %cmp37, label %if.then39, label %if.end41

if.then39:                                        ; preds = %if.else
  %call40 = call i32 (ptr, ...) @printf(ptr noundef @.str.20)
  br label %if.end41

if.end41:                                         ; preds = %if.then39, %if.else
  br label %if.end42

if.end42:                                         ; preds = %if.end41
  br label %while.body

while.end43:                                      ; preds = %if.then20
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cash_withdraw() #0 {
entry:
  %a = alloca %struct.customer, align 4
  %b = alloca %struct.customer, align 4
  %withdraw = alloca i32, align 4
  %temp = alloca [100 x i8], align 16
  %found = alloca i8, align 1
  %names_list = alloca ptr, align 8
  %new = alloca ptr, align 8
  store i32 0, ptr %withdraw, align 4
  store i8 70, ptr %found, align 1
  store ptr null, ptr %names_list, align 8
  store ptr null, ptr %new, align 8
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str.12)
  %username = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 0
  %arraydecay = getelementptr inbounds [50 x i8], ptr %username, i64 0, i64 0
  %call1 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.13, ptr noundef %arraydecay)
  %call2 = call noalias ptr @fopen(ptr noundef @.str, ptr noundef @.str.21)
  store ptr %call2, ptr %names_list, align 8
  br label %while.body

while.body:                                       ; preds = %entry, %if.end11
  %0 = load ptr, ptr %names_list, align 8
  %call3 = call i64 @fread(ptr noundef %b, i64 noundef 104, i64 noundef 1, ptr noundef %0)
  %cmp = icmp eq i64 %call3, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  br label %while.end

if.end:                                           ; preds = %while.body
  %username4 = getelementptr inbounds nuw %struct.customer, ptr %b, i32 0, i32 0
  %arraydecay5 = getelementptr inbounds [50 x i8], ptr %username4, i64 0, i64 0
  %username6 = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 0
  %arraydecay7 = getelementptr inbounds [50 x i8], ptr %username6, i64 0, i64 0
  %call8 = call i32 @strcmp(ptr noundef %arraydecay5, ptr noundef %arraydecay7) #7
  %cmp9 = icmp eq i32 %call8, 0
  br i1 %cmp9, label %if.then10, label %if.end11

if.then10:                                        ; preds = %if.end
  store i8 84, ptr %found, align 1
  br label %while.end

if.end11:                                         ; preds = %if.end
  br label %while.body

while.end:                                        ; preds = %if.then10, %if.then
  %1 = load i8, ptr %found, align 1
  %conv = sext i8 %1 to i32
  %cmp12 = icmp eq i32 %conv, 84
  br i1 %cmp12, label %if.then14, label %if.else

if.then14:                                        ; preds = %while.end
  br label %do.body

do.body:                                          ; preds = %do.cond, %if.then14
  %call15 = call i32 (ptr, ...) @printf(ptr noundef @.str.22)
  %call16 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.3, ptr noundef %withdraw)
  br label %do.cond

do.cond:                                          ; preds = %do.body
  %balance = getelementptr inbounds nuw %struct.customer, ptr %b, i32 0, i32 2
  %2 = load i32, ptr %balance, align 4
  %3 = load i32, ptr %withdraw, align 4
  %cmp17 = icmp slt i32 %2, %3
  br i1 %cmp17, label %do.body, label %do.end, !llvm.loop !6

do.end:                                           ; preds = %do.cond
  %balance19 = getelementptr inbounds nuw %struct.customer, ptr %b, i32 0, i32 2
  %4 = load i32, ptr %balance19, align 4
  %5 = load i32, ptr %withdraw, align 4
  %sub = sub nsw i32 %4, %5
  %balance20 = getelementptr inbounds nuw %struct.customer, ptr %b, i32 0, i32 2
  store i32 %sub, ptr %balance20, align 4
  %6 = load ptr, ptr %names_list, align 8
  %call21 = call i32 @fseek(ptr noundef %6, i64 noundef -104, i32 noundef 1)
  %7 = load ptr, ptr %names_list, align 8
  %call22 = call i64 @fwrite(ptr noundef %b, i64 noundef 104, i64 noundef 1, ptr noundef %7)
  %8 = load ptr, ptr %names_list, align 8
  %call23 = call i32 @fclose(ptr noundef %8)
  %arraydecay24 = getelementptr inbounds [100 x i8], ptr %temp, i64 0, i64 0
  %username25 = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 0
  %arraydecay26 = getelementptr inbounds [50 x i8], ptr %username25, i64 0, i64 0
  %call27 = call i32 (ptr, ptr, ...) @sprintf(ptr noundef %arraydecay24, ptr noundef @.str.16, ptr noundef %arraydecay26) #5
  %arraydecay28 = getelementptr inbounds [100 x i8], ptr %temp, i64 0, i64 0
  %call29 = call noalias ptr @fopen(ptr noundef %arraydecay28, ptr noundef @.str.1)
  store ptr %call29, ptr %new, align 8
  %9 = load ptr, ptr %new, align 8
  %10 = load i32, ptr %withdraw, align 4
  %call30 = call ptr @ctime(ptr noundef @t) #5
  %call31 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %9, ptr noundef @.str.23, i32 noundef %10, ptr noundef %call30) #5
  %11 = load ptr, ptr %new, align 8
  %call32 = call i32 @fclose(ptr noundef %11)
  br label %if.end39

if.else:                                          ; preds = %while.end
  %12 = load i8, ptr %found, align 1
  %conv33 = sext i8 %12 to i32
  %cmp34 = icmp eq i32 %conv33, 70
  br i1 %cmp34, label %if.then36, label %if.end38

if.then36:                                        ; preds = %if.else
  %call37 = call i32 (ptr, ...) @printf(ptr noundef @.str.24)
  br label %if.end38

if.end38:                                         ; preds = %if.then36, %if.else
  br label %if.end39

if.end39:                                         ; preds = %if.end38, %do.end
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cash_deposit() #0 {
entry:
  %a = alloca %struct.customer, align 4
  %b = alloca %struct.customer, align 4
  %deposit = alloca i32, align 4
  %temp = alloca [100 x i8], align 16
  %found = alloca i8, align 1
  %names_list = alloca ptr, align 8
  %new = alloca ptr, align 8
  store i32 0, ptr %deposit, align 4
  store i8 70, ptr %found, align 1
  store ptr null, ptr %names_list, align 8
  store ptr null, ptr %new, align 8
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str.12)
  %username = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 0
  %arraydecay = getelementptr inbounds [50 x i8], ptr %username, i64 0, i64 0
  %call1 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.13, ptr noundef %arraydecay)
  %call2 = call noalias ptr @fopen(ptr noundef @.str, ptr noundef @.str.21)
  store ptr %call2, ptr %names_list, align 8
  br label %while.body

while.body:                                       ; preds = %entry, %if.end11
  %0 = load ptr, ptr %names_list, align 8
  %call3 = call i64 @fread(ptr noundef %b, i64 noundef 104, i64 noundef 1, ptr noundef %0)
  %cmp = icmp eq i64 %call3, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  br label %while.end

if.end:                                           ; preds = %while.body
  %username4 = getelementptr inbounds nuw %struct.customer, ptr %b, i32 0, i32 0
  %arraydecay5 = getelementptr inbounds [50 x i8], ptr %username4, i64 0, i64 0
  %username6 = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 0
  %arraydecay7 = getelementptr inbounds [50 x i8], ptr %username6, i64 0, i64 0
  %call8 = call i32 @strcmp(ptr noundef %arraydecay5, ptr noundef %arraydecay7) #7
  %cmp9 = icmp eq i32 %call8, 0
  br i1 %cmp9, label %if.then10, label %if.end11

if.then10:                                        ; preds = %if.end
  store i8 84, ptr %found, align 1
  br label %while.end

if.end11:                                         ; preds = %if.end
  br label %while.body

while.end:                                        ; preds = %if.then10, %if.then
  %1 = load i8, ptr %found, align 1
  %conv = sext i8 %1 to i32
  %cmp12 = icmp eq i32 %conv, 84
  br i1 %cmp12, label %if.then14, label %if.else

if.then14:                                        ; preds = %while.end
  br label %do.body

do.body:                                          ; preds = %do.cond, %if.then14
  %call15 = call i32 (ptr, ...) @printf(ptr noundef @.str.25)
  %call16 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.3, ptr noundef %deposit)
  br label %do.cond

do.cond:                                          ; preds = %do.body
  %2 = load i32, ptr %deposit, align 4
  %rem = srem i32 %2, 10
  %cmp17 = icmp ne i32 %rem, 0
  br i1 %cmp17, label %do.body, label %do.end, !llvm.loop !8

do.end:                                           ; preds = %do.cond
  %balance = getelementptr inbounds nuw %struct.customer, ptr %b, i32 0, i32 2
  %3 = load i32, ptr %balance, align 4
  %4 = load i32, ptr %deposit, align 4
  %add = add nsw i32 %3, %4
  %balance19 = getelementptr inbounds nuw %struct.customer, ptr %b, i32 0, i32 2
  store i32 %add, ptr %balance19, align 4
  %5 = load ptr, ptr %names_list, align 8
  %call20 = call i32 @fseek(ptr noundef %5, i64 noundef -104, i32 noundef 1)
  %6 = load ptr, ptr %names_list, align 8
  %call21 = call i64 @fwrite(ptr noundef %b, i64 noundef 104, i64 noundef 1, ptr noundef %6)
  %7 = load ptr, ptr %names_list, align 8
  %call22 = call i32 @fclose(ptr noundef %7)
  %arraydecay23 = getelementptr inbounds [100 x i8], ptr %temp, i64 0, i64 0
  %username24 = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 0
  %arraydecay25 = getelementptr inbounds [50 x i8], ptr %username24, i64 0, i64 0
  %call26 = call i32 (ptr, ptr, ...) @sprintf(ptr noundef %arraydecay23, ptr noundef @.str.16, ptr noundef %arraydecay25) #5
  %arraydecay27 = getelementptr inbounds [100 x i8], ptr %temp, i64 0, i64 0
  %call28 = call noalias ptr @fopen(ptr noundef %arraydecay27, ptr noundef @.str.1)
  store ptr %call28, ptr %new, align 8
  %8 = load ptr, ptr %new, align 8
  %9 = load i32, ptr %deposit, align 4
  %call29 = call ptr @ctime(ptr noundef @t) #5
  %call30 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %8, ptr noundef @.str.26, i32 noundef %9, ptr noundef %call29) #5
  %10 = load ptr, ptr %new, align 8
  %call31 = call i32 @fclose(ptr noundef %10)
  br label %if.end38

if.else:                                          ; preds = %while.end
  %11 = load i8, ptr %found, align 1
  %conv32 = sext i8 %11 to i32
  %cmp33 = icmp eq i32 %conv32, 70
  br i1 %cmp33, label %if.then35, label %if.end37

if.then35:                                        ; preds = %if.else
  %call36 = call i32 (ptr, ...) @printf(ptr noundef @.str.24)
  br label %if.end37

if.end37:                                         ; preds = %if.then35, %if.else
  br label %if.end38

if.end38:                                         ; preds = %if.end37, %do.end
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @account_summary() #0 {
entry:
  %a = alloca %struct.customer, align 4
  %b = alloca %struct.customer, align 4
  %c = alloca i8, align 1
  %deposit = alloca i32, align 4
  %temp = alloca [100 x i8], align 16
  %found = alloca i8, align 1
  %names_list = alloca ptr, align 8
  %new = alloca ptr, align 8
  store i32 0, ptr %deposit, align 4
  store i8 70, ptr %found, align 1
  store ptr null, ptr %names_list, align 8
  store ptr null, ptr %new, align 8
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str.12)
  %username = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 0
  %arraydecay = getelementptr inbounds [50 x i8], ptr %username, i64 0, i64 0
  %call1 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.13, ptr noundef %arraydecay)
  %call2 = call i32 (ptr, ...) @printf(ptr noundef @.str.14)
  %password = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 1
  %arraydecay3 = getelementptr inbounds [50 x i8], ptr %password, i64 0, i64 0
  %call4 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.13, ptr noundef %arraydecay3)
  %call5 = call noalias ptr @fopen(ptr noundef @.str, ptr noundef @.str.21)
  store ptr %call5, ptr %names_list, align 8
  br label %while.body

while.body:                                       ; preds = %entry, %if.end14
  %0 = load ptr, ptr %names_list, align 8
  %call6 = call i64 @fread(ptr noundef %b, i64 noundef 104, i64 noundef 1, ptr noundef %0)
  %cmp = icmp eq i64 %call6, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  br label %while.end

if.end:                                           ; preds = %while.body
  %username7 = getelementptr inbounds nuw %struct.customer, ptr %b, i32 0, i32 0
  %arraydecay8 = getelementptr inbounds [50 x i8], ptr %username7, i64 0, i64 0
  %username9 = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 0
  %arraydecay10 = getelementptr inbounds [50 x i8], ptr %username9, i64 0, i64 0
  %call11 = call i32 @strcmp(ptr noundef %arraydecay8, ptr noundef %arraydecay10) #7
  %cmp12 = icmp eq i32 %call11, 0
  br i1 %cmp12, label %if.then13, label %if.end14

if.then13:                                        ; preds = %if.end
  store i8 84, ptr %found, align 1
  br label %while.end

if.end14:                                         ; preds = %if.end
  br label %while.body

while.end:                                        ; preds = %if.then13, %if.then
  %1 = load ptr, ptr %names_list, align 8
  %call15 = call i32 @fclose(ptr noundef %1)
  %2 = load i8, ptr %found, align 1
  %conv = sext i8 %2 to i32
  %cmp16 = icmp eq i32 %conv, 84
  br i1 %cmp16, label %land.lhs.true, label %if.else

land.lhs.true:                                    ; preds = %while.end
  %password18 = getelementptr inbounds nuw %struct.customer, ptr %b, i32 0, i32 1
  %arraydecay19 = getelementptr inbounds [50 x i8], ptr %password18, i64 0, i64 0
  %password20 = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 1
  %arraydecay21 = getelementptr inbounds [50 x i8], ptr %password20, i64 0, i64 0
  %call22 = call i32 @strcmp(ptr noundef %arraydecay19, ptr noundef %arraydecay21) #7
  %cmp23 = icmp eq i32 %call22, 0
  br i1 %cmp23, label %if.then25, label %if.else

if.then25:                                        ; preds = %land.lhs.true
  %arraydecay26 = getelementptr inbounds [100 x i8], ptr %temp, i64 0, i64 0
  %username27 = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 0
  %arraydecay28 = getelementptr inbounds [50 x i8], ptr %username27, i64 0, i64 0
  %call29 = call i32 (ptr, ptr, ...) @sprintf(ptr noundef %arraydecay26, ptr noundef @.str.16, ptr noundef %arraydecay28) #5
  %arraydecay30 = getelementptr inbounds [100 x i8], ptr %temp, i64 0, i64 0
  %call31 = call noalias ptr @fopen(ptr noundef %arraydecay30, ptr noundef @.str.15)
  store ptr %call31, ptr %new, align 8
  %call32 = call i32 (ptr, ...) @printf(ptr noundef @.str.27)
  br label %while.cond

while.cond:                                       ; preds = %while.body37, %if.then25
  %arraydecay33 = getelementptr inbounds [100 x i8], ptr %temp, i64 0, i64 0
  %3 = load ptr, ptr %new, align 8
  %call34 = call ptr @fgets(ptr noundef %arraydecay33, i32 noundef 100, ptr noundef %3)
  %cmp35 = icmp ne ptr %call34, null
  br i1 %cmp35, label %while.body37, label %while.end40

while.body37:                                     ; preds = %while.cond
  %arraydecay38 = getelementptr inbounds [100 x i8], ptr %temp, i64 0, i64 0
  %call39 = call i32 (ptr, ...) @printf(ptr noundef @.str.28, ptr noundef %arraydecay38)
  br label %while.cond, !llvm.loop !9

while.end40:                                      ; preds = %while.cond
  %4 = load ptr, ptr %new, align 8
  %call41 = call i32 @fclose(ptr noundef %4)
  br label %if.end43

if.else:                                          ; preds = %land.lhs.true, %while.end
  %call42 = call i32 (ptr, ...) @printf(ptr noundef @.str.29)
  br label %if.end43

if.end43:                                         ; preds = %if.else, %while.end40
  %5 = load ptr, ptr @stdin, align 8
  %call44 = call i32 @fflush(ptr noundef %5)
  %6 = load ptr, ptr @stdin, align 8
  %call45 = call i32 @getc(ptr noundef %6)
  %7 = load ptr, ptr @stdin, align 8
  %call46 = call i32 @getc(ptr noundef %7)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @check_balance() #0 {
entry:
  %retval = alloca i32, align 4
  %a = alloca %struct.customer, align 4
  %b = alloca %struct.customer, align 4
  %c = alloca i8, align 1
  %deposit = alloca i32, align 4
  %temp = alloca [100 x i8], align 16
  %found = alloca i8, align 1
  %names_list = alloca ptr, align 8
  %new = alloca ptr, align 8
  store i32 0, ptr %deposit, align 4
  store i8 70, ptr %found, align 1
  store ptr null, ptr %names_list, align 8
  store ptr null, ptr %new, align 8
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str.12)
  %username = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 0
  %arraydecay = getelementptr inbounds [50 x i8], ptr %username, i64 0, i64 0
  %call1 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.13, ptr noundef %arraydecay)
  %call2 = call i32 (ptr, ...) @printf(ptr noundef @.str.14)
  %password = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 1
  %arraydecay3 = getelementptr inbounds [50 x i8], ptr %password, i64 0, i64 0
  %call4 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.13, ptr noundef %arraydecay3)
  %call5 = call noalias ptr @fopen(ptr noundef @.str, ptr noundef @.str.21)
  store ptr %call5, ptr %names_list, align 8
  br label %while.body

while.body:                                       ; preds = %entry, %if.end14
  %0 = load ptr, ptr %names_list, align 8
  %call6 = call i64 @fread(ptr noundef %b, i64 noundef 104, i64 noundef 1, ptr noundef %0)
  %cmp = icmp eq i64 %call6, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  br label %while.end

if.end:                                           ; preds = %while.body
  %username7 = getelementptr inbounds nuw %struct.customer, ptr %b, i32 0, i32 0
  %arraydecay8 = getelementptr inbounds [50 x i8], ptr %username7, i64 0, i64 0
  %username9 = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 0
  %arraydecay10 = getelementptr inbounds [50 x i8], ptr %username9, i64 0, i64 0
  %call11 = call i32 @strcmp(ptr noundef %arraydecay8, ptr noundef %arraydecay10) #7
  %cmp12 = icmp eq i32 %call11, 0
  br i1 %cmp12, label %if.then13, label %if.end14

if.then13:                                        ; preds = %if.end
  store i8 84, ptr %found, align 1
  br label %while.end

if.end14:                                         ; preds = %if.end
  br label %while.body

while.end:                                        ; preds = %if.then13, %if.then
  %1 = load ptr, ptr %names_list, align 8
  %call15 = call i32 @fclose(ptr noundef %1)
  %2 = load i8, ptr %found, align 1
  %conv = sext i8 %2 to i32
  %cmp16 = icmp eq i32 %conv, 84
  br i1 %cmp16, label %land.lhs.true, label %if.else

land.lhs.true:                                    ; preds = %while.end
  %password18 = getelementptr inbounds nuw %struct.customer, ptr %b, i32 0, i32 1
  %arraydecay19 = getelementptr inbounds [50 x i8], ptr %password18, i64 0, i64 0
  %password20 = getelementptr inbounds nuw %struct.customer, ptr %a, i32 0, i32 1
  %arraydecay21 = getelementptr inbounds [50 x i8], ptr %password20, i64 0, i64 0
  %call22 = call i32 @strcmp(ptr noundef %arraydecay19, ptr noundef %arraydecay21) #7
  %cmp23 = icmp eq i32 %call22, 0
  br i1 %cmp23, label %if.then25, label %if.else

if.then25:                                        ; preds = %land.lhs.true
  %balance = getelementptr inbounds nuw %struct.customer, ptr %b, i32 0, i32 2
  %3 = load i32, ptr %balance, align 4
  %call26 = call i32 (ptr, ...) @printf(ptr noundef @.str.30, i32 noundef %3)
  br label %if.end28

if.else:                                          ; preds = %land.lhs.true, %while.end
  %call27 = call i32 (ptr, ...) @printf(ptr noundef @.str.31)
  br label %if.end28

if.end28:                                         ; preds = %if.else, %if.then25
  %4 = load ptr, ptr @stdin, align 8
  %call29 = call i32 @fflush(ptr noundef %4)
  %5 = load ptr, ptr @stdin, align 8
  %call30 = call i32 @getc(ptr noundef %5)
  %6 = load ptr, ptr @stdin, align 8
  %call31 = call i32 @getc(ptr noundef %6)
  %7 = load i32, ptr %retval, align 4
  ret i32 %7
}

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #3

declare i32 @system(ptr noundef) #2

declare i64 @fread(ptr noundef, i64 noundef, i64 noundef, ptr noundef) #2

; Function Attrs: nounwind willreturn memory(read)
declare i32 @strcmp(ptr noundef, ptr noundef) #4

; Function Attrs: nounwind
declare i32 @sprintf(ptr noundef, ptr noundef, ...) #1

; Function Attrs: nounwind
declare i32 @fprintf(ptr noundef, ptr noundef, ...) #1

; Function Attrs: nounwind
declare ptr @ctime(ptr noundef) #1

declare i64 @fwrite(ptr noundef, i64 noundef, i64 noundef, ptr noundef) #2

declare i32 @fseek(ptr noundef, i64 noundef, i32 noundef) #2

declare ptr @fgets(ptr noundef, i32 noundef, ptr noundef) #2

declare i32 @fflush(ptr noundef) #2

declare i32 @getc(ptr noundef) #2

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind willreturn memory(read) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }
attributes #7 = { nounwind willreturn memory(read) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 20.0.0git (https://github.com/llvm/llvm-project.git 7d4aa1ff6bab27b5442f4765336fa827479d7bbc)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
