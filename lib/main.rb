class Main
  require 'pdf/reader'
  require_relative 'model'


  def group_summary(page)

    client=page.text.scan(/.CLIE.+/)[0].split(" : ")[1].to_s
    bill = page.text.scan(/.BILL.+/)[0].split(" : ")[1].to_s
    totals = page.text.scan(/.C .+/)
    #threads=[]
    totals.each do |tot|
     # threads << Thread.new do
      ts=tot.split(" ")
    #  user = ts[1]
    #  spp = ts[2]
    #  ala = ts[3]
    #  ldarc = ts[4]
    #  dvao = ts[5]
    #  of = ts[9]
    #  gst = ts[12]
    #  st = ts[11]
    #  t = ts[13]
      group=Group.new(:client => client, :bill => bill, :user =>ts[1].to_s, :servpp => ts[2].to_s, :ala => ts[3].to_s, :ldarc => ts[4].to_s,:dvao => ts[5].to_s,:otherf => ts[9].to_s,:gst => ts[12].to_s,:subtotal=> ts[11].to_s,:total => ts[13].to_s)
       group.save
          #p "group save"

      #else
       # p "not'save"
      end
    #end
    #threads.each(&:join)
  end

  def individual_detail(page)
    client_number = page.text.scan(/.[\d]{3}-[\d]{3}-[\d]{4}/).to_s
    client_name = page.text.scan(/\w{3,}\s\w{3,}$/)[0].to_s
    pscan = page.text.scan(/.Total.+[\d]{1,3}.[\d]{2}/)
    i = 0
    itms = ""
    ispn = ""
    iala = ""
    ildc = ""
    idaos = ""
    ivas = ""
    itotal = ""
    if page.text.scan("Total Month's Savings").empty?.!
      #itms = (pscan[i].empty? ? "":pscan[i].split("$ ")[1].to_s)
      itms = pscan[i].split("$ ")[1].to_s
      i+=1
    end
    if page.text.scan("Service Plan Name").empty?.!

      #ispn= (pscan[i].empty? ? "":pscan[i].split("$ ")[1].to_s)
      ispn = pscan[i].split("$ ")[1].to_s
      i+=1
    end
    if page.text.scan("Additional Local Airtime").empty?.!
    #  iala= (pscan[i].empty? ? "":pscan[i].split("$ ")[1].to_s)
      iala = pscan[i].split("$ ")[1].to_s
      i+=1
    end
    if page.text.scan("Long Distance Charges").empty?.!
     # ildc= (pscan[i].empty? ? "":pscan[i].split("$ ")[1].to_s)
      ildc = pscan[i].split("$ ")[1].to_s
      i+=1
    end
    if page.text.scan("Data and Other Serv").empty?.!
     # idaos= (pscan[i].empty? ? "":pscan[i].split("$ ")[1].to_s)
      idaos = pscan[i].split("$ ")[1].to_s
      i+=1
    end
    if page.text.scan("Value Added Service").empty?.!
     # ivas= (pscan[i].empty? ? "":pscan[i].split("$ ")[1].to_s)
      ivas = pscan[i].split("$ ")[1].to_s
       i+=1
    end
    if page.text.scan("Total Current ").empty?.!
       i+=1
     # itotal= (pscan[i].empty? ? "":pscan[i].split("$ ")[1].to_s)
      itotal = pscan[i].split("$ ")[1].to_s

    end

    individ=Individual.new(:client_number => client_number, :client_name => client_name, :tms =>itms, :spn => ispn, :ala => iala, :ldc => ildc,:daos => idaos,:vas => ivas,:total => itotal)

    individ.save

  end

  def read_pdf(file)
    a=0
    doc = PDF::Reader.new(file)
    puts "Info about pdf file -> #{doc.info.inspect}"
    puts "Metadata from pdf file  -> #{doc.metadata.inspect}"
    puts "pdf file have #{doc.page_count} pages"

    threads=[]
    doc.pages.each do |page|

        if (page.text.scan(/.G R O U P S U M M A R Y - U S E R T O T .+/).empty?.!)
          group_summary(page)
        elsif (page.text.scan(/I N D I V I D U A L D E T A I L$/).empty?.!)
          a+=1
          if a<6
            individual_detail(page)
          else
            exit
          end
        end

    end
  end




end


