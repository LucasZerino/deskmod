# Copyright (C) 2012-2023 Zammad Foundation, https://zammad-foundation.org/

org_community = Organization.create_if_not_exists(
  id:   1,
  name: __('Desk 360 - Fundation'),
)
user_community = User.create_or_update(
  id:              2,
  login:           'beto.bolt@bolt360.com.br',
  firstname:       'Beto',
  lastname:        'Bolt 360',
  email:           'beto.bolt@bolt360.com.br',
  password:        '',
  active:          true,
  roles:           [ Role.find_by(name: 'Customer') ],
  organization_id: org_community.id,
)

UserInfo.current_user_id = user_community.id

if Ticket.count.zero?
  ticket = Ticket.create!(
    group_id:    Group.find_by(name: 'Users').id,
    customer_id: User.find_by(login: 'beto.bolt@bolt360.com.br').id,
    title:       __('Bem vindo ao Desk 360!'),
  )
  Ticket::Article.create!(
    ticket_id: ticket.id,
    type_id:   Ticket::Article::Type.find_by(name: 'phone').id,
    sender_id: Ticket::Article::Sender.find_by(name: 'Customer').id,
    from:      'Beto Bolt 360 <feedback@bolt360.com.br>',
    body:      'Bem vindo!

  Obrigado por utilizado o Desk 360.

  Você encontrará atualizações e patches em https://bolt360.com.br/. On-line
  a documentação está disponível em https://bolt360.com.br/. Pegar
  envolvidos (discussões, contribuições, ...) em https://bolt360.com.br/.

  Cumprimentos,

  Sua Assessoria 360
  ',
    internal:  false,
  )
end

UserInfo.current_user_id = 1
