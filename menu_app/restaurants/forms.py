from django import forms


class SearchForm(forms.Form):
    price = forms.IntegerField(label='Pretul maxim al meniului', required=False,
                               widget=forms.TextInput(attrs={'placeholder': 'ex: 25'}))
    start_hour = forms.IntegerField(label='Ora de incepere (ex: daca completati cu ora 13, se vor afisa meniurile care incep inainte de ora 13) ',
                                    required=False, widget=forms.TextInput(attrs={'placeholder': 'ex: 10'}))
    end_hour = forms.IntegerField(label='Ora de sfarsit (ex: daca completati cu ora 15, se vor afisa meniurile care se termina dupa ora 15)',
                                  required=False, widget=forms.TextInput(attrs={'placeholder': 'ex: 16'}))
    has_soup = forms.BooleanField(label='Doriti ca meniul sa contina supa?', required=False)
    has_drink = forms.BooleanField(label='Doriti ca meniul sa contina ceva de baut?', required=False)
    has_dessert = forms.BooleanField(label='Doriti ca meniul sa contina desert?', required=False)
    soup = forms.CharField(label='Supa ', required=False,
                           widget=forms.TextInput(attrs={'placeholder': 'perisoare'}))
    main_course = forms.CharField(label='Felul principal ', required=False,
                                  widget=forms.TextInput(attrs={'placeholder': 'ex: pui'}))
    side = forms.CharField(label='Garnitura ', required=False,
                           widget=forms.TextInput(attrs={'placeholder': 'ex: orez'}))
    dessert = forms.CharField(label='Desertul ', required=False,
                              widget=forms.TextInput(attrs={'placeholder': 'ex: negresa'}))
    drink = forms.CharField(label='Bautura ', required=False,
                            widget=forms.TextInput(attrs={'placeholder': 'ex: limonada'}))
