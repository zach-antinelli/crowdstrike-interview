#!/usr/bin/env python3

import os
import sys
import openai

"""
Interact with the OpenAI API using the davinci model.

You must set the environment variable "OPENAI_API_KEY"
    
Usage:
            
    Non-interactive example:
        
        python openai_terminal.py "Should I HODL?"

        ./openai_terminal.py "What is love?"

    Interactive example:

        python openai_terminal.py -i

        python openai_terminal.py interactive

        ./openai_terminal --interactive

        openai>> Should I HODL?

        It depends on your individual goals and risk tolerance. HODLing is a strategy that involves holding a cryptocurrency 
        for a long period of time, usually in the hopes of it increasing in value. If you are comfortable with the risks associated 
        with cryptocurrency investing and believe that the potential rewards are worth it, then HODLing may be a good strategy for 
        you. However, it is important to remember that cryptocurrencies are volatile and the market can be unpredictable, so it is 
        important to do your own research and make sure you understand the risks before investing.
"""

def non_interactive(prompt):
    """
    Non-interactive prompt, run the script with a string argument.
    """
    completions = openai.Completion.create(
        engine="text-davinci-003",
        prompt=prompt,
        max_tokens=1024,
        n=1,
        stop=None,
        temperature=0.5,
    )
    return completions.choices[0].text.strip()

def interactive():
    """
    Interactive prompt, ask as many questions as you like.
    """
    try:
        while True:
            prompt = input("openai>> ")
            if prompt in ("exit", "Exit", "quit", "Quit", "bye", "Bye"):
                sys.exit()
            completions = openai.Completion.create(
                engine="text-davinci-003",
                prompt=prompt,
                max_tokens=1024,
                n=1,
                stop=None,
                temperature=0.5,
            )
            print("\n" + completions.choices[0].text.strip() + "\n")
    except KeyboardInterrupt:
        sys.exit("\nKeyboard interrupt received, exiting..")

def main():
    if len(sys.argv) != 2 or sys.argv[1] in ("-h","--help"):
        print("""
        Usage:
            
            Non-interactive example:
                
                python openai_terminal.py "Should I HODL?"

                ./openai_terminal.py "What is love?"

            Interactive example:

                python openai_terminal.py -i

                ./openai_terminal --interactive

                python openai_terminal.py interactive

            """)
        sys.exit(1)
    if not "OPENAI_API_KEY" in os.environ:
        print("API Key has not been set. Set environment variable: OPENAI_API_KEY")
        sys.exit(1)
    input_arg = sys.argv[1]
    if input_arg in ("-i","--interactive","interactive"):
        interactive()
    print(non_interactive(input_arg))

if __name__ == "__main__":
    main()
