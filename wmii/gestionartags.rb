#!/usr/bin/env ruby
    def calculartags(newtags)
        currenttag=`wmiir read ctl`.split("\n")[0].split[1]
        currenttags=`wmiir read /client/sel/tags`
        ctags=currenttags.split("+")
        resultado=currenttags
        if newtags[0].chr == "+"
            ntags=newtags.sub(/^./,"").split "+"
            resultado = (ctags + ntags) * "+"
        elsif newtags[0].chr == "-"
            if newtags.size == 1
                if ctags.size > 1
                    ctags.delete currenttag
                    resultado = ctags * "+"
                end
            end
        else
            resultado = newtags
        end
        return resultado

    end

    def write(file, contents)
        IO.popen("wmiir write #{file}", "w"){|io| io.print contents.to_s }
        true
    rescue Errno::EPIPE
        return false
    end

newtags=`echo "" | dmenu`
listatags=calculartags(newtags)
write "/client/#{`wmiir read /client/sel/ctl`}/tags",listatags
