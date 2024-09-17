; ModuleID = 'test/nnLoop.c'
source_filename = "test/nnLoop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @foo() #0 {
entry:
  %sum = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %n = alloca i32, align 4
  %h = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 0, ptr %sum, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc17, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 10
  br i1 %cmp, label %for.body, label %for.end19

for.body:                                         ; preds = %for.cond
  store i32 0, ptr %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc7, %for.body
  %1 = load i32, ptr %j, align 4
  %cmp2 = icmp slt i32 %1, 20
  br i1 %cmp2, label %for.body3, label %for.end9

for.body3:                                        ; preds = %for.cond1
  store i32 0, ptr %k, align 4
  br label %for.cond4

for.cond4:                                        ; preds = %for.inc, %for.body3
  %2 = load i32, ptr %k, align 4
  %cmp5 = icmp slt i32 %2, 20
  br i1 %cmp5, label %for.body6, label %for.end

for.body6:                                        ; preds = %for.cond4
  %3 = load i32, ptr %k, align 4
  %4 = load i32, ptr %sum, align 4
  %add = add nsw i32 %4, %3
  store i32 %add, ptr %sum, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body6
  %5 = load i32, ptr %k, align 4
  %inc = add nsw i32 %5, 1
  store i32 %inc, ptr %k, align 4
  br label %for.cond4, !llvm.loop !6

for.end:                                          ; preds = %for.cond4
  br label %for.inc7

for.inc7:                                         ; preds = %for.end
  %6 = load i32, ptr %j, align 4
  %inc8 = add nsw i32 %6, 1
  store i32 %inc8, ptr %j, align 4
  br label %for.cond1, !llvm.loop !8

for.end9:                                         ; preds = %for.cond1
  store i32 0, ptr %n, align 4
  br label %for.cond10

for.cond10:                                       ; preds = %for.inc14, %for.end9
  %7 = load i32, ptr %n, align 4
  %cmp11 = icmp slt i32 %7, 10
  br i1 %cmp11, label %for.body12, label %for.end16

for.body12:                                       ; preds = %for.cond10
  %8 = load i32, ptr %n, align 4
  %9 = load i32, ptr %sum, align 4
  %add13 = add nsw i32 %9, %8
  store i32 %add13, ptr %sum, align 4
  br label %for.inc14

for.inc14:                                        ; preds = %for.body12
  %10 = load i32, ptr %n, align 4
  %inc15 = add nsw i32 %10, 1
  store i32 %inc15, ptr %n, align 4
  br label %for.cond10, !llvm.loop !9

for.end16:                                        ; preds = %for.cond10
  br label %for.inc17

for.inc17:                                        ; preds = %for.end16
  %11 = load i32, ptr %i, align 4
  %inc18 = add nsw i32 %11, 1
  store i32 %inc18, ptr %i, align 4
  br label %for.cond, !llvm.loop !10

for.end19:                                        ; preds = %for.cond
  store i32 99, ptr %h, align 4
  %12 = load i32, ptr %h, align 4
  %13 = load i32, ptr %h, align 4
  %mul = mul nsw i32 %12, %13
  store i32 %mul, ptr %b, align 4
  ret void
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
!10 = distinct !{!10, !7}
