class DictionaryHandler

  def load_dic
    if File.exists?("dic") and !File.zero?("dic")
      puts "using old dic"
      File.open('dic') do |f|  
	@lt = Marshal.load(f)  
      end
    else
      puts "creating new letter tree object"
      @lt = LetterTree.new
    end
    @lt
  end

  def dump(lt)
    File.open('dic', 'w+') do |f|  
      Marshal.dump(lt, f)  
    end 
  end

  def list_mode(b)
    @lt = load_dic
    puts
    puts b.report_words_in_lt(@lt)
  end

end
