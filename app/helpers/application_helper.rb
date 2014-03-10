module ApplicationHelper
  # Regresa el título completo para una página.
  def titulo_completo(titulo_pagina)
    titulo_base = "Cb-blog"
	if titulo_pagina.empty?
	  titulo_base
	else
	  "#{titulo_base} | #{titulo_pagina}"
	end
  end
  
  #Seleccionar imagen del avatar por default o personalizada.
  def avatarURL(user, size)
  	if user.avatar.url == nil
  	  return '/uploads/user/avatar/' + size + '_user.png'
    else
      return user.avatar.url(size)
    end
  end

  #Lista de usuarios de enviado a con su estatus (visto / no visto)
  def lista_usuarios(id, type)
    case type
    when 'micropost'
      lista = Micropostaddressee.list_micropost_addressees(id).to_a
    when 'article'
      lista = Articleaddressee.list_article_addressees(id).to_a
    end
    listaTooltip = lista.first(5)
    excedTooltip = lista.size - 5
    agrupar = listaTooltip.group_by{|t| t[0]}.values
    tabla = agrupar.map do |porcion|
      "<table>\n" << "<tr>" << porcion.map do |columna|
        "<td>" << columna.map do |elemento|
          elemento[1]
        end.join("</td><td>") << "</td>"
      end.join("</tr>\n<tr>") << "</tr>"
    end.join("\n")
    if excedTooltip > 0
      tabla << "<tr><td colspan='2'>haz click para ver los #{lista.size} usuarios.</td></tr>\n</table>\n"
    else
      tabla << "</table>\n"
    end
    return tabla
  end
end