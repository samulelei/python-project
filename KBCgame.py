import random
import mysql.connector
import time
import sys

#SLOT MACHINES................................................................................

def slots(current_location):
    print('Welcome to the Lucky 7 slot machine.')
    print('Do you want to play? Type yes/no.')
    action = input()
    moneydb()
    if int(moneydb()) == 0:
        print('You don\'t have enough money to play the slot machine.')
        locationName(current_location)
        return
    while int(moneydb()) >= 0 and action == 'yes' or action != 'no':
        while action != 'yes' and action != 'no':
            print('yes/no')
            action = input()
            moves_add()
        if action == 'i' or action == 'inventory':
            inventory()
        elif action == 'yes':
            while int(moneydb()) > 0 and action != 'no':
                print('You have ',moneydb(),' euros.')
                print('Place your bet. Min = 1e and Max = 10e. Type help to see how to win. Type no to leave.')
                bet = input()
                moves_add()
                if bet == 'no' or bet == 'leave' or bet == 'exit':
                    print('\n' * 100)
                    locationName(current_location)
                    return
                elif bet == 'help':
                    print('You win x10 if you get the numbers: 111, 222 or 333.')
                    print('You win x20 if you get the numbers: 444, 555 or 666.')
                    print('You win x3 if you get the number: 7 at the first or the last column.')
                    print('You win x6 if you get at least two number 7\'s')
                    print('You win x50 Jackpot if you get the numbers: 777')
                elif bet.isnumeric():
                    maxbet = 10
                    int(maxbet)
                    if int(bet) == 0:
                        print('The minimum bet is 1 euro.')
                    if int(bet) > int(maxbet):
                        print('The maximum bet is 10 euros.')
                    elif int(bet) > int(moneydb()):
                        print('You can\'t bet more than you have.')

                    elif int(bet) <= int(moneydb()) and int(bet) <= maxbet and int(bet) > 0:
                        row1 = random.randrange(1, 8)
                        row2 = random.randrange(1, 8)
                        row3 = random.randrange(1, 8)
                        print('\n'*100)
                        slow_printS('['+str(row1)+']'),slow_printS('['+str(row2)+']'),slow_printS('['+str(row3)+']'),print()
                        slp1()
                        money_loss(int(bet))


                        if row1 == 1 and row2 == 1 and row3 == 1 or row1 == 2 and row2 == 2 and row3 == 2 or row1 == 3 and row2 == 3 and row3 == 3:
                            win = int(bet) * 10
                            print('Congratulations you won ' + str(win) + ' euros!')
                            money_add(win),slp2()
                        elif row1 == 4 and row2 == 4 and row3 == 4 or row1 == 5 and row2 == 5 and row3 == 5 or row1 == 6 and row2 == 6 and row3 == 6:
                            win = int(bet) * 20
                            print('Congratulations you won ' + str(win) + ' euros!')
                            money_add(win),slp2()
                        elif row1 == 7 and row2 == 7 and row3 == 7:
                            win = int(bet) * 50
                            print('JACKPOT!!! You won ' + str(win) + ' euros!')
                            money_add(win),slp2()
                        elif row1 + row2 == 14 or row1 + row3 == 14 or row2 + row3 == 14:
                            win = int(bet) * 6
                            print('Congratulations you won ' + str(win) + ' euros!')
                            money_add(win),slp2()
                        elif row1 == 7 or row3 == 7:
                            win = int(bet) * 3
                            print('Congratulations you won ' + str(win) + ' euros!')
                            money_add(win),slp2()
                        else:
                            print('You won nothing.'),slp2()
                            if int(moneydb()) == 0:
                                print('You have lost all of your money.')
                                print('You leave the slot machine with ', moneydb(), ' euros in your pocket.')
                                input('Press enter to continue.')
                                print('\n' * 100)
                                locationName(current_location)
                                return
                else:
                    print('Please use correct input.')

        if int(moneydb()) == 0:
            print('You have lost all of your money.')
            print('You leave the slot machine with ', moneydb(), ' euros in your pocket.')
            input('Press enter to continue.')
            print('\n' * 100)
            locationName(current_location)
            return

    print('You leave the slot machine with ',moneydb(),' euros in your pocket.')
    input('Press enter to continue.')
    print('\n' * 100)
    locationName(current_location)
    return

#Player Character.........................................................................

#MoneyFetch gets the current ammount of money from the db. (Used everywhere in the program)
def moneydb():
    cur = db.cursor()
    cur.execute("SELECT Money FROM Player WHERE ID = 1")
    for row in cur.fetchall():
        money = (row[0])
    return money

#DrunkFetch get the current ammount of drunkOmeter from the db. (Used everywhere in the program)
def drunkdb():
    cur = db.cursor()
    cur.execute("SELECT DrunkOmeter FROM Player WHERE ID = 1")
    for row in cur.fetchall():
        drunk = (row[0])
    return drunk

#Fetches the current bartab from the db.
def bartabdb(current_location):
    cur = db.cursor()
    cur.execute("SELECT Bartab FROM Location WHERE ID='" + current_location + "'")
    for row in cur.fetchall():
        current_tab = (row[0])
    return current_tab

#Bartab decrease.
def bartab_dec(current_location):
    current_tab = bartabdb(current_location)
    cur = db.cursor()
    new_tab = int(current_tab) - 1
    cur.execute("UPDATE Location SET Bartab='" + str(int(new_tab))+ "'WHERE ID='" + current_location + "'")
    return new_tab

#When the player gets money from somewhere, it's added to the db.
def money_add(loot):
    result = moneydb()
    cur = db.cursor()
    money = int(result) + int(loot)
    cur.execute("UPDATE Player SET Money ='" + str(int(money)) + "'WHERE ID = 1")
    return

#When the player loses money, it's subtracted from the db.
def money_loss(loss):
    result = moneydb()
    money = int(result) - int(loss)
    cur = db.cursor()
    cur.execute("UPDATE Player SET Money ='" + str(int(money)) + "'WHERE ID = 1")
    return

#When the player fills their drunkOmeter, it's added to the db.
def drunkometer_add(points):
    current_drunk = drunkdb()
    new_drunk = int(current_drunk) + int(points)
    cur = db.cursor()
    cur.execute("UPDATE Player SET Drunkometer ='" + str(int(new_drunk)) + "'WHERE ID = 1")
    cur.execute("SELECT Maxdrunkometer FROM Player WHERE ID = 1")
    for row in cur.fetchall():
        maxdrunk=(row[0])
    if new_drunk >= maxdrunk:
        gameVictory()
    return

def moves_fetch():
    cur = db.cursor()
    cur.execute("SELECT Moves FROM Player WHERE ID = 1")
    for row in cur.fetchall():
        current_moves = (row[0])
    return current_moves

#Player actions counter:
def moves_add():
    current_moves=moves_fetch()
    new_moves = int(current_moves) + 1
    cur = db.cursor()
    cur.execute("UPDATE Player SET Moves ='" + str(int(new_moves)) + "'WHERE ID =1 ")
    cur.execute("SELECT Maxmoves FROM Player WHERE ID =1")
    for row in cur.fetchall():
        limit = (row[0])
    if new_moves >= limit:
        moveLimit()
    return

#Help command.
def help():
    slow_print2('Basic controls:'),print(),slp2()
    slow_print2('Use: n, s, w, e to move around.'),print(),slp3()
    slow_print2('Use: in or out to go in and out of a bar.'),print(),slp3()
    slow_print2('You can also use search, rob, examine, take, play and look around commands.'),print()
    input('Press enter when ready.')
    print('\n'*100)
    locationName(Gcurrent_location)

#When the player uses the inventory command.
def inventory():
    print('You have',moneydb(),'euros.')
    print('You are',drunkdb(),'percent drunk.')
    cur = db.cursor()
    cur.execute("SELECT Name FROM Object WHERE PlayerID IS NOT NULL")
    if cur.rowcount >= 1:
        print('You are also carrying:')
        for row in cur.fetchall():
            print('-',row[0])
        for row in cur.fetchall():
            print('-',row[1])
        for row in cur.fetchall():
            print('-',row[2])
        for row in cur.fetchall():
            print('-',row[3])
    cur.execute("SELECT PlayerID FROM Object WHERE PlayerID IS NOT NULL AND Name = 'lasol'")
    lasol = cur.fetchone()
    cur.execute("SELECT PlayerID FROM Object WHERE PlayerID IS NOT NULL AND Name = 'sponge'")
    sponge = cur.fetchone()
    cur.execute("SELECT PlayerID FROM Object WHERE PlayerID IS NOT NULL AND Name = 'funnel'")
    funnel = cur.fetchone()
    if lasol == (1,) and sponge == (1,) and funnel == (1,):
        print('Maybe you could combine your lasol, sponge and funnel.')
    return

#Slow printer for a dramatic effect.
def slow_print1(text):
    for c in text:
        time.sleep(0.4)
        print(c, end='')
        sys.stdout.flush()

#A bit faster.
def slow_print2(text):
    for c in text:
        time.sleep(0.01)
        print(c, end='')
        sys.stdout.flush()

def slow_print3(text):
    for c in text:
        time.sleep(0.8)
        print(c, end='')
        sys.stdout.flush()

def slow_printS(text):
    for c in text:
        time.sleep(0.3)
        print(c, end='')
        sys.stdout.flush()

#Time sleep1
def slp1():
    time.sleep(0.3)

#Time sleep2
def slp2():
    time.sleep(1)

#Time sleep3
def slp3():
    time.sleep(2)

#When the player wins.
def gameVictory():
    slp2(),print('You got black out drunk.'),print()
    slow_print2('____   ____.__        __                        ._.'),slp1(),print()
    slow_print2('\   \ /   /|__| _____/  |_  ___________ ___.__. | |'),print()
    slow_print2(' \   Y   / |  |/ ___\   __\/  _ \_  __ <   |  | | |'),print()
    slow_print2('  \     /  |  \  \___|  | (  <_> )  | \/\___  |  \|'),print()
    slow_print2('   \___/   |__|\___  >__|  \____/|__|   / ____|  __'),print()
    slow_print2('                   \/                   \/       \/'),print()
    slp2()
    current_moves=moves_fetch()
    print('You used',current_moves,'actions to compelete the game.')
    tryagain()

#When the player dies.
def gameover():
    time.sleep(4)
    print('_____.___.              ________  .__           .___'),slp1()
    print('\__  |   | ____  __ __  \______ \ |__| ____   __| _/'),slp1()
    print(' /   |   |/  _ \|  |  \  |    |  \|  |/ __ \ / __ | '),slp1()
    print(' \____   (  <_> )  |  /  |    `   \  \  ___// /_/ | '),slp1()
    print(' / ______|\____/|____/  /_______  /__|\___  >____ | '),slp1()
    print(' \/                             \/        \/     \/ '),slp1()
    slp2()
    print('  ________                        ________   '),slp1()
    print(' /  _____/_____    _____   ____   \_____  \___  __ ___________ '),slp1()
    print('/   \  ___\__  \  /     \_/ __ \   /   |   \  \/ // __ \_  __ \ '),slp1()
    print('\    \_\  \/ __ \|  Y Y  \  ___/  /    |    \   /\  ___/|  | \/'),slp1()
    print(' \______  (____  /__|_|  /\___  > \_______  /\_/  \___  >__| '),slp1()
    print('        \/     \/      \/     \/          \/          \/'),slp1()
    slp2()
    tryagain()

#When the player runs out of actions.
def moveLimit():
    slow_print2('!'*10)
    print()
    print('You took too long and the time is up.')
    time.sleep(2)
    print('You got',drunkdb(),'percent drunk, but that\'s not good enough.')
    time.sleep(2)
    print('  ________                        ________   '),slp1()
    print(' /  _____/_____    _____   ____   \_____  \___  __ ___________ '),slp1()
    print('/   \  ___\__  \  /     \_/ __ \   /   |   \  \/ // __ \_  __ \ '),slp1()
    print('\    \_\  \/ __ \|  Y Y  \  ___/  /    |    \   /\  ___/|  | \/'),slp1()
    print(' \______  (____  /__|_|  /\___  > \_______  /\_/  \___  >__| '),slp1()
    print('        \/     \/      \/     \/          \/          \/'),slp1()
    slp2()
    tryagain()

#Examine....................................................................................

#When the player examines a trash bin.
def examineTrash(current_location):
    cur = db.cursor()
    cur.execute("SELECT Description FROM Object WHERE Location='" + current_location + "'AND Name ='trash bin' AND Available = 1")
    if cur.rowcount >= 1:
        for row in cur.fetchall():
            print(row[0])
    else:
        print('No trash bins here.')
    return

#When the player examines a grandma.
def examineGrandma(current_location):
    cur = db.cursor()
    cur.execute("SELECT Description FROM Object WHERE Location='" + current_location + "'AND Name ='grandma' AND Available = 1")
    if cur.rowcount >= 1:
        for row in cur.fetchall():
            print(row[0])
    else:
        print('No grandmas here.')
    return

#When the player examines a bodybuilder.
def examineBodybuilder(current_location):
    cur = db.cursor()
    cur.execute("SELECT Description FROM Object WHERE Location='" + current_location + "'AND Name ='bodybuilder' AND Available = 1")
    if cur.rowcount >= 1:
        for row in cur.fetchall():
            print(row[0])
    else:
        print('No bodybuilders here.')
    return

#When the player examines a bar counter.
def examineBarcounter(current_location):
    cur = db.cursor()
    cur.execute("SELECT Description FROM Object WHERE Location='" + current_location + "'AND Name ='bar counter' AND Available = 1")
    if cur.rowcount >= 1:
        for row in cur.fetchall():
            print(row[0])
    else:
        print('No bar counters here.')
    return

#When the player examines a slot machine.
def examineSlots(current_location):
    cur = db.cursor()
    cur.execute("SELECT Description FROM Object WHERE Location='" + current_location + "'AND Name ='slot machine' AND Available = 1")
    if cur.rowcount >= 1:
        for row in cur.fetchall():
            print(row[0])
    else:
        print('No slot machines here.')
    return

#When the player examines lasol.
def examineLasol(current_location):
    cur = db.cursor()
    cur.execute("SELECT Description FROM Object WHERE (Location='" + current_location + "'AND Name ='lasol' AND Available = 1) OR (PlayerID = 1 AND Name = 'lasol')")
    if cur.rowcount >= 1:
        for row in cur.fetchall():
            print(row[0])
    else:
        print('Lasol? Are you crazy?')
    return

#When the player examines sponge.
def examineSponge(current_location):
    cur = db.cursor()
    cur.execute("SELECT Description FROM Object WHERE (Location='" + current_location + "'AND Name ='sponge' AND Available = 1) OR (PlayerID = 1 AND Name = 'sponge')")
    if cur.rowcount >= 1:
        for row in cur.fetchall():
            print(row[0])
    else:
        print('A sponge?')
    return

#When the player examines funnel.
def examineFunnel(current_location):
    cur = db.cursor()
    cur.execute("SELECT Description FROM Object WHERE (Location='" + current_location + "'AND Name ='sponge' AND Available = 1) OR (PlayerID = 1 AND Name = 'funnel')")
    if cur.rowcount >= 1:
        for row in cur.fetchall():
            print(row[0])
    else:
        print('Funnel? I\'ll show you a funnel.')
    return

#When the player examines a knife.
def examineKnife(current_location):
    cur = db.cursor()
    cur.execute("SELECT Description FROM Object WHERE Name ='knife' AND PlayerID = 1")
    if cur.rowcount >= 1:
        for row in cur.fetchall():
            print(row[0])
    else:
        print('I don\'t have a knife.')
    return

#BUYING..................................................................

#When the player's action is just a 'buy' and no valid target.
def buy(current_location):
    cur = db.cursor()
    cur.execute("SELECT Available FROM Object WHERE Location='" + current_location + "'AND Name ='bar counter'")
    if cur.rowcount >= 1:
        print('You can buy beer or vodka.')
        print('Beer is 5 euros and vodka is 12 euros.')
    else:
        print('Buy what from where?')
    return

#When the player buys a beer.
def beer(current_location):
    cur = db.cursor()
    cur.execute("SELECT Available FROM Object WHERE Location='" + current_location + "'AND Name ='bar counter'")
    if cur.rowcount >= 1:
        money = moneydb()
        if int(money) >= 5:
            money_loss(5)
            bartab = bartab_dec(current_location)
            print('You bought a beer with 5 euros and drank it filling your drunkOmeter by 3 points.')
            drunkometer_add(3)
            if bartab == 0:
                thrown_out(current_location)
                global Gcurrent_location
                Gcurrent_location = move(current_location, direction='out')

                locationName(Gcurrent_location)
                lock(Gcurrent_location)
                return
        else:
            print('You don\'t have enough money to buy a beer.')
    else:
        print('You need to be inside of a bar to buy beer.')
    return

#When the player buys vodka.
def vodka(current_location):
    cur = db.cursor()
    cur.execute("SELECT Available FROM Object WHERE Location='" + current_location + "'AND Name ='bar counter'")
    if cur.rowcount >= 1:
        money = moneydb()
        if int(money) >= 12:
            money_loss(12)
            bartab = bartab_dec(current_location)
            print('You bought a shot of vodka with 12 euros and drank it filling your drunkOmeter by 6 points.')
            drunkometer_add(6)
            if bartab == 0:
                thrown_out(current_location)
                global Gcurrent_location
                Gcurrent_location = move(current_location, direction='out')

                locationName(Gcurrent_location)
                lock(Gcurrent_location)
                return
        else:
            print('You don\'t have enough money to buy vodka.')
    else:
        print('You need to be inside of a bar to buy vodka.')
    return


#Robbing.....................................................................................
#Robbing a grandma
def grandma(current_location):
    cur = db.cursor()
    cur.execute("SELECT Available FROM Object WHERE Location='" + current_location + "'AND Name ='grandma'")
    Available = (cur.fetchone())
    if Available == (1,):
        cur = db.cursor()
        cur.execute("UPDATE Object SET Available = FALSE WHERE Location='" + current_location + "'AND Name = 'grandma'")
        cur.execute("SELECT PlayerID FROM Object WHERE Name = 'knife'")
        knife = cur.fetchone()
        print('Robbing grandma', end=''), slow_print1('.' * 5)
        if knife == (1,):
            loot = random.randrange(1,6)
            print('Grandma is scared of your knife.'),slp1()
            print('She throws some money at your general direction and runs away.')
            print('You got',loot,'euros.')
            money_add(loot)
        else:
            loot = random.randrange(0,16)
            if loot <= 1:
                print('Grandma swings you with her purse and leaves.')
            else:
                print('You threatened the grandma with your fists and you managed to get', loot, 'euros.')
                money_add(loot)
    else:
        print('There are no grandmas here.')
    return

#Robbing a bodybuilder.
def bodybuilder(current_location):
    cur = db.cursor()
    cur.execute("SELECT Available FROM Object WHERE Location='" + current_location + "'AND Name ='bodybuilder'")
    Available = (cur.fetchone())
    if Available == (1,):
        cur = db.cursor()
        cur.execute("UPDATE Object SET Available = FALSE WHERE Location='" + current_location + "'AND Name = 'bodybuilder'")
        cur.execute("SELECT PlayerID FROM Object WHERE Name = 'knife'")
        knife = cur.fetchone()
        print('Robbing bodybuilder', end=''), slow_print1('.' * 4)
        if knife == (1,):
            loot = random.randrange(40,51)
            print('You threatened the bodybuilder with your knife.'),slp2()
            print('And you were able to get some money out of him, but you lost your knife.')
            print('You got',loot,'euros.')
            cur.execute("UPDATE Object SET PlayerID = NULL WHERE Name = 'knife'")
            money_add(loot)
        else:
            print('The bodybuilder punches you and you fall down and hit your head on to the sidewalk.')
            gameover()
    else:
        print('There are no bodybuilders here.')
    return

#Trash bin searching.
def trashbin(current_location):
    cur = db.cursor()
    cur.execute("SELECT Available FROM Object WHERE Location='" + current_location + "'AND Name ='trash bin'")
    Available = (cur.fetchone())
    if Available == (1,):
        cur.execute("UPDATE Object SET Available = FALSE WHERE Location='" + current_location + "'AND Name = 'trash bin'")
        print('Searching trash bin',end='')
        slow_print1('.'*4)
        cur.execute("SELECT PlayerID FROM Object WHERE Name = 'knife'")
        knife = cur.fetchone()
        loot = random.randrange(0, 11)
        if knife != (1,) and loot <= 2:
            print('you found a knife.')
            cur = db.cursor()
            cur.execute("UPDATE Object SET PlayerID = 1 WHERE Name = 'knife'")
        elif loot == 0:
            print('you found nothing.')
        else:
            print('you found',loot,'euros.')
            money_add(loot)
    else:
        print('There is no trash bin to loot here.')
    return

#Take..................................................................................
def take(current_location,target):
    cur = db.cursor()
    if target == 'lasol':   #Take Lasol
        cur.execute("SELECT Available FROM Object WHERE Location ='" + current_location + "'AND Available IS TRUE AND Name = 'lasol'")
        if cur.rowcount >= 1:
            cur.execute("UPDATE Object SET Available = FALSE, PlayerID = 1 WHERE Name = 'lasol'")
            print('You took the white bottle labeled lasol.')
        else:
            print('There is no lasol to take.')
    elif target == 'sponge':    #Take Sponge
        cur.execute("SELECT Available FROM Object WHERE Location ='" + current_location + "'AND Available IS TRUE AND Name = 'sponge'")
        if cur.rowcount >= 1:
            cur.execute("UPDATE Object SET Available = FALSE WHERE Name = 'sponge'")
            cur.execute("UPDATE Object SET PlayerID = 1 WHERE Name = 'sponge'")
            print('You took the rough looking sponge.')
        else:
            print('There is no sponge to take.')
    elif target == 'funnel':    #Take Funnel
        cur.execute("SELECT Available FROM Object WHERE Location ='" + current_location + "'AND Available IS TRUE AND Name = 'funnel'")
        if cur.rowcount >= 1:
            cur.execute("UPDATE Object SET Available = FALSE WHERE Name = 'funnel'")
            cur.execute("UPDATE Object SET PlayerID = 1 WHERE Name = 'funnel'")
            print('You took the red funnel.')
        else:
            print('There is no funnel here to take.')
    else:
        print('I can\'t take',target,'.')
    return

#Combine lasol, sponge and funnel.
def combine():
    cur = db.cursor()
    cur.execute("SELECT PlayerID FROM Object WHERE Name = 'lasol'")
    lasol = cur.fetchone()
    cur.execute("SELECT PlayerID FROM Object WHERE Name = 'sponge'")
    sponge = cur.fetchone()
    cur.execute("SELECT PlayerID FROM Object WHERE Name = 'funnel'")
    funnel = cur.fetchone()
    if lasol == (1,) and sponge == (1,) and funnel == (1,):
        cur.execute("UPDATE Object SET PlayerID = NULL WHERE Name = 'lasol'")
        cur.execute("UPDATE Object SET PlayerID = NULL WHERE Name = 'sponge'")
        cur.execute("UPDATE Object SET PlayerID = NULL WHERE Name = 'funnel'")
        print('Combining lasol, sponge and funnel',end='')
        slow_print1('.'*10)
        print('you successfully crafted a home made turbo beverage and drank it filling your drunkOmeter by 50 points.')
        drunkometer_add(50)
    else:
        print('Can\'t combine. Maybe I\'m missing something.')
    return

#Location.............................................................................

#Prints name of the current location..............
def locationName(current_location):
    cur = db.cursor()
    cur.execute("SELECT Details FROM Location WHERE ID='" + current_location + "'")
    for row in cur:
        print('You\'re',row[0])
    location_description(current_location)

#Prints description of the current location.......
def location_description(current_location):
    cur = db.cursor()
    cur.execute("SELECT Description FROM Location WHERE ID='" + current_location + "'")
    for row in cur:
        print(row[0])
    objectNames(current_location)

#Prints object names in the current location......
def objectNames(current_location):
    cur = db.cursor()
    cur.execute("SELECT Name FROM Object WHERE Location='" + current_location + "'AND Available = TRUE")
    if cur.rowcount >= 1:
        print('You can see the following things: ')
        for row in cur:
            print('-',row[0])
    return

#Movement..............................................................................
def move(current_location, direction):
    red = 0
    cur = db.cursor()
    cur.execute("SELECT Locked FROM Passage WHERE Direction= 'in' AND Source='" + current_location + "'")
    lock = (cur.fetchone())
    if lock == (1,) and direction == 'in':
        cur.execute("SELECT Locknote FROM Passage WHERE Source ='" + Gcurrent_location + "'AND Direction = 'in'")
        for row in cur.fetchall():
            print(row[0])
    if direction == 's' and (Gcurrent_location == 'hesaripenger' or Gcurrent_location == 'hesariharju' or Gcurrent_location == 'hesarikustaa' or Gcurrent_location == 'hesariflemari'):
        red = 1
        redlight(Gcurrent_location)
        locationName(Gcurrent_location)

    cur.execute("SELECT Destination FROM Passage WHERE Direction='" + direction + "' AND Source='" + current_location + "' AND Locked = 0")
    if cur.rowcount >= 1:
        print('\n' * 100)
        for row in cur.fetchall():
            destination = row[0]
    else:
        destination = current_location
        if red!=1:
            print("You can\'t move to that direction.")
    return destination

#Thrown out from a bar....................................
def thrown_out(current_location):
    slp1()
    cur = db.cursor()
    cur.execute("SELECT Throwoutdesc FROM Location WHERE ID='" + current_location + "'")
    for row in cur.fetchall():
        print(row[0])
    slp1()
    input('Press enter to continue.')
    return

#Location lock..........................................
def lock(current_location):
    cur = db.cursor()
    cur.execute("UPDATE Passage SET Locked = 1 WHERE source ='" + current_location +"'AND Direction = 'in'")
    return


#When player tries to crossover Helsinginkatu............
def redlight(current_location):
    print('The ligth is currently red for pedestrians.')
    print('Do you still want to cross?')
    action = input()
    moves_add()
    while action != 'yes' or action != 'no':
        if action == 'yes' or action == 'y':
            print('Crossing over',end=''),slow_print1('.'*6),slow_print2('!!!'),slp1(),print('you were run over by a car.')
            print()
            gameover()
        elif action == 'no' or action == 'n':
            return
        else:
            action = input('yes/no')

#When player drinks lasol...................
def drinkLasol():
    cur = db.cursor()
    lasol = cur.execute("SELECT PlayerID FROM Object WHERE Name = 'lasol'")
    for row in cur.fetchall():
        lasol=(row[0])
    if lasol == 1:
        print('Drinking lasol',end=''),slow_print1('.'*10),print('you died of alcohol poisoning.')
        gameover()
    else:
        print('No lasol to drink.')
        return

#Try again...................................................................
def tryagain():
    db.rollback()
    global Gcurrent_location
    Gcurrent_location = "vaasanaukio"
    playagain = input ('Would you like to try again?')
    while playagain != 'yes' or playagain != 'no':
        if playagain == 'yes' or playagain == 'y':
            mainmenu()
        elif playagain == 'no' or playagain == 'n':
            print ('Thank you for playing Kallio Bar Crawl!')
            exit()
        else:
            print('yes/no')
            playagain = input()

#Main Menu................
def mainmenu():
    print(' ____  __.___________________  '), slp1()
    print('|    |/ _|\______   \_   ___ \ '), slp1()
    print('|      <   |    |  _/    \  \/ '), slp1()
    print('|    |  \  |    |   \     \____'), slp1()
    print('|____|__ \ |______  /\______  /'), slp1()
    print('        \/        \/        \/ '), slp1()

    print('Welcome to the world of Kallio Bar Crawl.')
    print('Try to get drunk as fast as possible by any means necessary.')
    input('Press "enter" to start the game.')
    print('\n' * 1000)
    MainGameLoop()

#Game loop...................
def MainGameLoop():
    game_loop = 1
    global  Gcurrent_location
    locationName(Gcurrent_location)  # Global current location.
    while game_loop == 1:

        #Input-------------------------------

        player_input = input('').split()
        if len(player_input)>=1:
            action = player_input[0].lower()
        else:
            action = ""
        if len(player_input)>=2:
            target = player_input[len(player_input)-1].lower()
        else:
            target = ""
        print()
        moves_add()

        #Cheat Codes----------------------------------
        if action == 'makemerichyousexybitch':
            money_add(1000)
            print('Money cheat activated. You got 1000 euros.')
        elif action == 'makemeabalisongprobro':
            print('Knife cheat activated. You got a knife.')
            cur = db.cursor()
            cur.execute("UPDATE Object SET PlayerID = 1 WHERE Name = 'knife'")


        #Inventory------------------------------------
        elif action == 'i' or action == 'inventory':
            inventory()

        #Help--------------------------------------
        elif action == 'h' or action == 'help':
            help()

        #Look around-------------------------------
        elif action == 'look' and target == 'around':
            locationName(Gcurrent_location)

        #Examine--------------------------------------
        elif action == 'examine' or action == 'look':
            if target == 'bin' or target == 'trash':
                examineTrash(Gcurrent_location)
            elif target == 'grandma':
                examineGrandma(Gcurrent_location)
            elif target == 'bodybuilder':
                examineBodybuilder(Gcurrent_location)
            elif target == 'counter':
                examineBarcounter(Gcurrent_location)
            elif target == 'lasol':
                examineLasol(Gcurrent_location)
            elif target == 'sponge':
                examineSponge(Gcurrent_location)
            elif target == 'funnel':
                examineFunnel(Gcurrent_location)
            elif target == 'knife':
                examineKnife(Gcurrent_location)
            elif target == 'slots' or target == 'machine':
                examineSlots(Gcurrent_location)
            else:
                print('I don\'t know how to', action, target + '.')

        #BUY-------------------------------------------
        elif action == 'buy':
            if target == 'beer':
                beer(Gcurrent_location)
            elif target == 'vodka':
                vodka(Gcurrent_location)
            elif target != 'beer' or target != 'vodka':
                buy(Gcurrent_location)

        #Robbing---------------------------------------
        elif action == 'rob':
            if target == 'grandma' or target == 'granny':
                grandma(Gcurrent_location)
            elif target == 'bodybuilder' or target == 'bb':
                bodybuilder(Gcurrent_location)
            else:
                print('I don\'t know how to', action, target + '.')

        #Search------------------------------------
        elif action == 'search' or action == 'loot':
            if target == 'bin' or target == 'trash':
                trashbin(Gcurrent_location)
            else:
                print('I don\'t know how to', action, target + '.')

        #Take------------------------------------------------
        elif action == 'take':
            take(Gcurrent_location,target)

        #Combination------------------------------------------
        elif action == 'combine':
            combine()

        #Playing slot machine---------------------------------
        elif action == 'play' or action == 'use':
            if target == 'slots' or target == 'machine':
                cur = db.cursor()
                cur.execute("SELECT Name FROM Object WHERE Location = '" + Gcurrent_location + "' AND Name = 'slot machine'")
                slotsHere = (cur.fetchone())
                if slotsHere == ('slot machine',):
                    slots(Gcurrent_location)
                else:
                    print('No',target,'here.')
            else:
                print('I don\'t know how to', action, target + '.')

        #Drink lasol------------------------------------------
        elif action == 'drink':
            if target == 'lasol':
                drinkLasol()
            else:
                print('No,',target,'to drink.')


        #Movement----------------------------------------------
        elif action == 'north' or action == 'n' or action == 'west' or action == 'w' or action == 'south' or action == 's' or action == 'east' or action == 'e' \
        or action == 'inside' or action == 'in' or  action == 'enter' or (action == 'go' and (target == 'in' or target == 'inside')) or \
        action == 'outside' or action == 'out' or action == 'leave' or action == 'exit' or (action == 'go' and (target == 'out' or target == 'outside')):
            if action == 'north':
                action = 'n'
            if action == 'south':
                action = 's'
            if action == 'west':
                action = 'w'
            if action == 'east':
                action = 'e'
            if action == 'inside' or action == 'enter' or target == 'in' or target == 'inside':
                action = 'in'
            if action == 'outside' or action == 'exit' or action == 'leave' or target == 'out' or target == 'outside':
                action = 'out'

            newlocation = move(Gcurrent_location,action)

            if Gcurrent_location == newlocation:
                print(end='')
            else:
                Gcurrent_location = newlocation
                locationName(Gcurrent_location)
        #Quit----------
        elif action == 'quit':
            quit = input('Are you sure you want to quit?')
            quit[0].lower()
            if quit == 'yes':
                exit()
        elif action == '' and target == '':
            print()

        #Wrong Input-------------------
        else:
            if target != '':
                print('I don\'t know how to', action,target+'.')
            else:
                print('I don\'t know how to',action+'.')

#Program starts,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

db = mysql.connector.connect(host="localhost",user="dbuser01",passwd="dbpass",db="kbc",buffered=True)

Gcurrent_location = "vaasanaukio"

mainmenu()
