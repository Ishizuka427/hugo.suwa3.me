---
title: "Hacker Rank"
date: "2021-06-26T10:00:00.000Z"
categories: 
  - "tech-blog"
tags: 
  - "Tech"
---

諸事情あり Hacker Rank の Bash 試験の練習問題を解きました！  
いろいろあって悲しかったので、昇華するための output です。  

# Linux Shell/Bash

1. Let's Echo
Write a bash script that prints the string "HELLO".

```sh
echo "HELLO"
```

2. Looping and Skipping
Your task is to use for loops to display only odd natural numbers from  1 to 99.

```sh
for i in {1..99}
do
    if [ $((i % 2)) = 1 ] 
    then
        echo $i
    fi
done
```

3. Looping with Numbers
Use a for loop to display the natural numbers from  1 to 50.

```sh
for i in {1..50}
do
    echo $i
done
```

4. A Personalized Echo
Write a Bash script which accepts  as input and displays the greeting "Welcome (name)".

```sh
read name
echo Welcome $name
```

5. The World of Numbers
Given two integers,  X and Y , find their sum, difference, product, and quotient.

```sh
read X
read Y

ADD=$((X + Y))
SUB=$((X - Y)) 
PROD=$((X * Y))
DIV=$((X / Y))

echo $ADD
echo $SUB
echo $PROD
echo $DIV
```

6. Comparing Numbers
Given two integers,  X and Y , identify whether X<Y or X>Y or X=Y.

```sh
read X
read Y

if [ $(( X>Y )) = 1 ] ; then
    echo "X is greater than Y"
elif [ $(( Y>X )) = 1 ] ; then
    echo "X is less than Y"
else
    echo "X is equal to Y"
fi
```

7. Getting started with conditionals
Read in one character from STDIN.
- If the character is 'Y' or 'y' display "YES".
- If the character is 'N' or 'n' display "NO".
- No other character will be provided as input.

```sh
read ANS

case $ANS in
    "" | [Yy]* )
        echo "YES"
        ;;
    "" | [Nn]* )
        echo "NO"
        ;;
esac
```

8. More on Conditionals
Given three integers (X, Y, and Z) representing the three sides of a triangle, identify whether the triangle is scalene, isosceles, or equilateral.
- If all three sides are equal, output EQUILATERAL.
- Otherwise, if any two sides are equal, output ISOSCELES.
- Otherwise, output SCALENE.

```sh
read X
read Y
read Z

if [ $(( X==Y && Y==Z )) = 1 ] ; then
    echo "EQUILATERAL"
elif [ $(( X!=Y && Y!=Z )) = 1 ] ; then
    echo "SCALENE"
else
    echo "ISOSCELES"
fi
```

9. Arithmetic Operations
A mathematical expression containing +,-,*,^, / and parenthesis will be provided. Read in the expression, then evaluate it. Display the result rounded to 3 decimal places.

```sh
read FORMULA

RESULT=`echo "scale=4; $FORMULA" | bc`
printf "%.3f" $RESULT
```

10. Compute the Average
Given N integers, compute their average, rounded to three decimal places.  
わかりませんでした！！  
わかった方は教えて下さい。  
https://www.hackerrank.com/challenges/bash-tutorials---compute-the-average/problem  

# 感想
Bash を書いたあとに Python を書くと「import の存在を忘れるなぁ」と、思いました。