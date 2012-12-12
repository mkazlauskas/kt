# Reed-Muller kodo kontrolleris.
# Kontroliuoja naujo kodo kurima
# ir esamo kodo atvaizdavima

class ReedMullersController < ApplicationController

  def create
    @reed_muller = ReedMuller.new(params[:reed_muller])
    if @reed_muller.save
      case params[:commit]
        when "String Message" then redirect_to new_string_message_path(reed_muller_id: @reed_muller.id)
        else redirect_to new_binary_vector_path(reed_muller_id: @reed_muller.id)
      end
    else
      render "new"
    end
  end

  def new
    @reed_muller = ReedMuller.new
  end
  
  # Parodo, kaip veikia kodas pritaikant ji
  # vektoriaus arba tekstines zinutes siuntimui
  def show
    @reed_muller = ReedMuller.find_by_id(params[:id])
    return redirect_to root_path if @reed_muller.nil?
    if !@reed_muller.binary_vector.nil?

      # Siunciam vektoriu
      if params[:binary_vector].nil?
        @received_vector = @reed_muller.channel.send_vector(@reed_muller.encode_vector(@reed_muller.binary_vector))
      else
        params[:binary_vector][:size] = @reed_muller.encode_vector(@reed_muller.binary_vector).count
        @received_vector = BinaryVector.create(params[:binary_vector])
      end
      if @received_vector.errors.count == 0

        # Rodom klaidas
        errors = Channel.diff(@reed_muller.encode_vector(@reed_muller.binary_vector).elements, @received_vector.elements)
        @error_indexes = errors.map { |i| i.to_s }.join(', ')
        
        # Jei klaidu per daug, rodom pranesima
        if errors.count > (0.5*((2**(@reed_muller.m-@reed_muller.r))-1))
          flash.now[:error] = "Too many errors for this code"
        end

        # Rodom dekoduota vektoriu
        @decoded_vector = @reed_muller.decode_vector(@received_vector)
      end
    elsif !@reed_muller.string_message.nil?

      # Siunciam tekstine zinute
      @original = @reed_muller.string_message
      bits_array = @reed_muller.string_message.bits_array(@reed_muller.code_length)
      
      # Rodom, kaip atrodo neuzkoduota persiusta zinute
      @sent_no_code = StringMessage.new
      @sent_no_code.load_bits(@reed_muller.channel.send_vector(BinaryVector.new(elements: bits_array.join(''))).elements)
      
      # Rodom, kaip atrodo uzkoduota persiusta zinute
      received_bits = ''
      bits_array.each do |bits_chunk|
        encoded = @reed_muller.encode_vector(BinaryVector.new(elements: bits_chunk))
        sent = @reed_muller.channel.send_vector(encoded)
        received_bits << @reed_muller.decode_vector(sent).elements
      end
      @received = StringMessage.new
      @received.load_bits(received_bits)
    end
  end
end