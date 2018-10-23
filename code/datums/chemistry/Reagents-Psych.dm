// Meant to contain more RP centered medication for therapists on 1 to use/people to add to their drug cocktails.

/datum/reagent/
    psych/
        name = "some psychiatric medication"
    psych/diazepam
        name = "Diazepam"
        id = "Diazepam"
        desc = "A weak benzodiazepine medication that produces a calming sedative effect, commonly used for the treatment of anxiety"
        addiction_prob = 10
	var/remove_buff
	on_remove()
		if(istype(holder) && istype(holder.my_atom) && hascall(holder.my_atom,"remove_stam_mod_max"))
			holder.my_atom:remove_stam_mod_max("diazepam")
		return

        on_mob_life()
	    var/mob/living/carbon/human/K = M
            if(!M) 
                M = holder.my_atom
            if(!amount || !degree)
                var/amount = holder.get_reagent_amount(src.id)
            if(prob(15))
		for(var/datum/ailment_data/disease/virus in M.ailments)
                        if(istype(virus.master,/datum/ailment/disease/space_madness) || istype(virus.master, /datum/ailment/disability/epilepsy))
                            M.cure_disease(virus)
            if(amount < 10) // Regular calming.
                if(prob(10))
                    	boutput(M, pick("<span style=\"color:red\">You feel less anxious.</span>"), "<span style=\"color:red\">You feel a bit more mellowed out.</span>", "<span style=\"color:red\">You feel relaxed.</span>", <span style=\"color:red\">You feel sleepy.</span>")
                if(prob(5))
                    	M.emote(pick("smile", "grin", "yawn")
		if (K.sims)
			K.sims.affectMotive("energy", -1)
                   	K.sims.affectMotive("comfort", 1)
            if(amount > 10 && amount < 30) // Severe sedation
                if(prob(10))
                   	boutput(M, pick("<span style=\"color:red\">You feel like you should just lie down somewhere and sleep.</span>"), "<span style=\"color:red\">You feel weak.</span>", "<span style=\"color:red\">You feel very sleepy.</span>")
                if(prob(15))
                    	M.emote(pick("faint", "yawn", "collapse")
                if (K.sims)
			K.sims.affectMotive("energy", -3)
                    	K.sims.affectMotive("comfort", 1)
		if (M.a_intent != INTENT_HELP && prob(10))
                    	boutput(M, <span style=\"color:red\">You're too tired to attack people right now.</span>")
                    	M.a_intent = INTENT_HELP
                if(!HasEffect(/datum/bioEffect/clumsy))
                     	M:bioHolder.AddEffect(/datum/bioEffect/clumsy, timeleft = 60)
		if(istype(holder) && istype(holder.my_atom) && hascall(holder.my_atom,"add_stam_mod_max"))
			holder.my_atom:add_stam_mod_max("diazepam", -25)
		if(M.m_intent == "run" && prob(25))
			boutput(M, "<span style=\"color:red\">Your legs feel like jelly!</span>")
			M.m_intent = "walk"
             if(amount > 30) // Severe and continual oxygen damage
	     	if (!M.paralysis)
			boutput(M, "<span style=\"color:red\">You pass out!</span>")
			M.emote("collapse", "gasp", "shiver")
			M.paralysis += 2
			M.weakened += 2
		if (prob(20))
			M.take_oxygen_damage(4)
                       	M.updatehealth()
