INVENTORY = inventory.ini
GROUP = myhosts
PLAYBOOK = playbook.yaml
SWAP_PLAYBOOK = swap.yaml

include ./files/.env
export

run:
	ansible-playbook -i ${INVENTORY} ${PLAYBOOK}

swap:
	ansible-playbook -i ${INVENTORY} ${SWAP_PLAYBOOK}

all: swap
	${MAKE} run

ping:
	ansible ${GROUP} -m ping -i ${INVENTORY}