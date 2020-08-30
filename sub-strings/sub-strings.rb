require 'pry'

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def get_string
    # Prompt user for input
    print 'Enter a word: '
    # Capture user input formatted with no line-break
    input_str = gets.chomp.downcase
    # Return user input
    input_str
end

def substrings (dictionary, string)
    contained_words = {}

    dictionary.map { |dict_word|
        if (string.scan(dict_word).length > 0)
            contained_words[dict_word] = string.scan(dict_word).length
        end
    }

    # string.split(" ").map { |str_word|
    #     dictionary.map { |dict_word|
    #         if (str_word.include? dict_word)
    #             if (contained_words.include? dict_word)
    #                 contained_words[dict_word] += 1
    #             else
    #                 contained_words[dict_word] = 1
    #             end
    #         end
    #     }
    # }
    
    # apple_stock > 1 ? :eat_apple : :buy_apple
    contained_words.length == 0 ? (p "Word not found!") : (p contained_words)
end


substrings(dictionary, get_string) 


  