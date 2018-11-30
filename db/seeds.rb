u1 = User.create! name: 'joe', role: :cto
u2= User.create! name: 'joe2', role: :cto

u3 = User.create! name: 'jane', role: :secretaire
u4 = User.create! name: 'jane2', role: :secretaire

u5 = User.create! name: 'jack', role: :ceo
u6 = User.create! name: 'jack2', role: :ceo

u7 = User.create! name: 'john', role: :comptable

s1 = Sector.create! name: 'Sector-1'
s2 = Sector.create! name: 'Sector-2'
s3 = Sector.create! name: 'Sector-3'

s11 = Sector.create! name: 'Sector-1-1', parent_sector: s1
s12 = Sector.create! name: 'Sector-1-2', parent_sector: s1

s21 = Sector.create! name: 'Sector-2-1', parent_sector: s2
s22 = Sector.create! name: 'Sector-2-2', parent_sector: s2

s31 = Sector.create! name: 'Sector-3-1', parent_sector: s3

SectorsUsers.create! sector: s1, user: u1
SectorsUsers.create! sector: s11, user: u1
SectorsUsers.create! sector: s12, user: u1

