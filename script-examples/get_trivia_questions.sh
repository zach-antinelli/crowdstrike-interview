#!/bin/bash

# Uses the Open Trivia DB API to pull trivia questions
# Takes two args n for number of questions and d for difficulty (easy, medium or hard) of the questions
# if args are not given, amount will default to 10 and difficulty to easy
# 
# Example: get_trivia_questions n=10 d=easy 
#

function get_trivia_questions() {
    if [[ -z ${1+x} ]]; then amount=${1:-10}; else amount=$(echo "$1" | sed "s/.*=//"); fi
    if [[ -z ${2+x} ]]; then difficulty=${2:-easy}; else difficulty=$(echo "$2" | sed "s/.*=//"); fi
    url="https://opentdb.com/api.php?amount=$amount&difficulty=$difficulty"
    curl -s  $url | jq -r '.results[]'
}

get_trivia_questions n=500 d=hard

