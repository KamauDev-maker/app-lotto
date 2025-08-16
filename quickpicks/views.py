import random
from django.shortcuts import render

def generate_quick_pick():
    # get 5 numbers from 1-25
    low_numbers = random.sample(range(1, 26), 5)
    
    # get 2 number from 26-50
    high_numbers = random.sample(range(26, 51), 2)
    
    #combine sort
    quick_pick = sorted(low_numbers + high_numbers)
    return quick_pick

def generate_encore():
    # generates a random 7-digits encore number
    return ''.join(str(random.randint(0, 9)) for _ in range(7))

def quick_pick_view(request):
    picks = []
    for _ in range(5):
        picks.append({
            "lotto": generate_quick_pick(),
            "encore": generate_encore()
        })
    return render(request, "quickpicks.html", {"picks":picks})