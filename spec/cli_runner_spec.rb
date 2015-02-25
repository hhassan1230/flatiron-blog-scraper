describe CLIRunner do
  # question what is a hash
  # question -f what is a hash
  # question -q what is a hash
  # question -f -t ruby -q what is a hash
  # question -t ruby -q what is a hash
  # question -t ruby rails -q what is a hash
  # question -f -t ruby rails -q what is a hash
  # [no good] question -f ewrwedf -t ruby rails -q what is a hash

  let(:runner) { CLIRunner.new }

  describe '#parse_question_input' do
    it 'should accept a string' do
      input = "hello"
      expect{runner.parse_question_input(input)}.to_not raise_error()
    end

    it 'should accept -f flag' do
      input = "question -f what is a hash"
      runner.parse_question_input(input)
      expect(runner.query).to eq("what is a hash")
      expect(runner.flags).to eq({:f => true})
    end

    it 'should parse correctly without -q flag' do
      input = "question what is a hash"
      runner.parse_question_input(input)

      expect(runner.query).to eq("what is a hash")
      expect(runner.flags.empty?).to eq(true)
    end

    it 'should parse correctly with -q flag' do
      input = "question -q what is a hash"
      runner.parse_question_input(input)

      expect(runner.query).to eq("what is a hash")
      expect(runner.flags).to eq({:q => true})
    end
    
    it 'should accept a -t flag' do
      input = "question -t ruby -q what is a hash"
      runner.parse_question_input(input)

      expect(runner.query).to eq("what is a hash")
      expect(runner.flags).to eq({:q => true, :t => ["ruby"]})
    end

    it 'should accept multipule -t flags' do
      input = "question -t ruby rails -q what is a hash"
      runner.parse_question_input(input)

      expect(runner.query).to eq("what is a hash")
      expect(runner.flags).to eq({:q => true, :t => ["ruby", "rails"]})
    end

    it 'should show error if the -t flag arguments aren\'t followed by a -q flag' do
      input = "question -t ruby rails what is a hash"

      runner.parse_question_input(input)
      # binding.pry
      # expect($stdout).to eq("hello")
      expect($stdout).to receive(puts "what is a hash")
    end




  end
end
