#!/usr/bin/ruby
#
#Translates MIPS instructions into human readable descriptions

def insr(numero)
	tipo=Hash[32,"add",34,"sub",8,"jr"] #Campo aluop
	rs="0b"+numero.slice(6..10)
	rs= "%d" % rs
	rt="0b"+numero.slice(11..15)
	rt= "%d" % rt
	rd="0b"+numero.slice(16..20)
	rd= "%d" % rd
	aluop="0b"+numero.slice(26..31)
	aluop= "%d" % aluop
	if aluop.to_i==8 then
		return "jr $"+rs
	else
		return tipo.fetch(aluop.to_i)+" $"+rd+" $"+rs+" $"+rt
	end
end

def insi(numero)
	tipo=Hash[4,"beq",8,"addi",35,"lw",43,"sw"] #Campo op
	op="0b"+numero.slice(0..5)
	op= "%d" % op
	rs="0b"+numero.slice(6..10)
	rs= "%d" % rs
	rd="0b"+numero.slice(11..15)
	rd= "%d" % rd
	inmediato="0b"+numero.slice(16..31)
	inmediato= "%x" % inmediato #a hexadecimal
	if tipo.fetch(op.to_i)=="beq" then
		return tipo.fetch(op.to_i)+" $"+rs+" $"+rd+" "+inmediato
	end
	if tipo.fetch(op.to_i)=="addi" then
		return "addi $"+rd+" $"+rs+" "+inmediato
	end
	return tipo.fetch(op.to_i)+" $"+rd+" 0x"+inmediato+"($"+rs+")"
end

def insj(numero)
	tipo=Hash[2,"j",3,"jal"] #Campo op
	op="0b"+numero.slice(0..5)
	op= "%d" % op
	dir= "0b"+numero.slice(6..31)
	dir= "%x" % dir #mejor hexadecimal
	return tipo.fetch(op.to_i)+" 0x"+dir
end
	


def inse(numero)
	tipo=Hash[0,"mfc0",4,"mtc0",16,"rfe"] #Campo rs
	rs="0b"+numero.slice(6..10)
	rs= "%d" % rs
	rt="0b"+numero.slice(11..15)
	rt= "%d" % rt
	rd="0b"+numero.slice(16..20)
	rd= "%d" % rd
	aluop="0b"+numero.slice(26..31)
	aluop= "%d" % aluop
	if rs.to_i==16 then
		return "rfe"
	end
	return tipo.fetch(rs.to_i)+" $"+rt+" $"+rd
end

def rellenar(cadena,limite) #pone 0 a la izq
	(limite-cadena.size()).times{
		cadena="0"+cadena
	}
	return cadena
end

def bin2txt(cadena)
	formato=Hash[0,"R",2,"J",3,"J",4,"I",8,"I",16,"E",35,"I",43,"I"] #tipos de instruccion
	numero = "%b" % cadena
	numero=rellenar(numero,32)
	op = "0b"+numero.slice(0..5)
	op= "%d" % op
	if not formato.has_key?(op.to_i) then
		return "Desconocido"
	end
	tipo=formato.fetch(op.to_i)
	case tipo
	when "R"
		return insr(numero)
	when "I"
		return insi(numero)
	when "J"
		return insj(numero)
	when "E"
		return inse(numero)
	end

end

begin
	if ARGV.size()==0 then
		puts "","mip.rb"," Programa para transformar instrucciones binarias a texto","","Uso:","   -c [Archivo] Pasar un fichero binario a texto","   -x Para pasar los argumentos a binario",""
		
	else	
		if ARGV[0]=="-c" then
			archivo=File.open(ARGV[1],"r+")
			while not archivo.eof
				cadena = "0x"+archivo.gets
				puts bin2txt(cadena)
			end
		end
		if ARGV[0]=="-x" then
			case ARGV[1]
			when "R"
				op="%b" % ARGV[2]
				op=rellenar(op,6)
				rd="%b" % ARGV[3]
				rd=rellenar(rd,5)
				rs="%b" % ARGV[4]
				rs=rellenar(rs,5)
				rt="%b" % ARGV[5]
				rt=rellenar(rt,5)
				aluop="%b" % ARGV[6]
				aluop=rellenar(aluop,6)
				total= "0b"+op+rs+rt+rd+"00000"+aluop
				total= "%x" % total
				total=rellenar(total,8)
				puts total
			when "I"
				op="%b" % ARGV[2]
				op=rellenar(op,6)
				rd="%b" % ARGV[3]
				rd=rellenar(rd,5)
				rs="%b" % ARGV[4]
				rs=rellenar(rs,5)
				inmediato="%b" % ARGV[5]
				inmediato=rellenar(inmediato,16)
				total= "0b"+op+rs+rd+inmediato
				total= "%x" % total
				total=rellenar(total,8)
				puts total
			when "J"
				op="%b" % ARGV[2]
				op=rellenar(op,6)
				j="%b" % ARGV[3]
				j=rellenar(j,26)
				total= "0b"+op+j
				total= "%x" % total
				total=rellenar(total,8)
				puts total

			end
		end
	end
end
