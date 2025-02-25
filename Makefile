INVENTORY = inventory.ini
GROUP = myhosts
PLAYBOOK = playbook.yaml

include ./files/.env
export

all:
	ansible-playbook -i ${INVENTORY} ${PLAYBOOK}

ping:
	ansible ${GROUP} -m ping -i ${INVENTORY}