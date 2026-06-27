import string

class Alphabet:
      def __init__(self, lang: str, letters: list):
        self.lang = lang 
        self.letters = letters
        
      def print(self):
        print(f"Літери алфавіту ({self.lang}): {', '.join(self.letters)}")
        
      def letters_num(self) -> int:
        return len(self.letters)

ukr_alphabet = Alphabet(lang='UA', letters=['А', 'Б', 'В', 'Г', 'Ґ'])

ukr_alphabet.print()
print(f"Кількість літер: {ukr_alphabet.letters_num()}")

class EngAlphabet(Alphabet):
  _letters_num = 26
  def __init__(self):
    letters_list = list(string.ascii_uppercase)
    super().__init__(lang='Eng', letters=letters_list)
  
  def is_en_letter(self, letter: str) -> bool:
    return letter.upper() in self.letters
  
  def letters_num(self) -> int:
     return self._letters_num
   
  @staticmethod
  def example() -> str:
        return "Output an example text in English."

if __name__ == "__main__":
    eng_alphabet = EngAlphabet()

    eng_alphabet.print()

    print(f"Кількість літер: {eng_alphabet.letters_num()}")

    letter_f = 'F'
    print(f"Чи належить літера '{letter_f}' алфавіту? {eng_alphabet.is_en_letter(letter_f)}")

    letter_shch = 'Щ'
    print(f"Чи належить літера '{letter_shch}' алфавіту? {eng_alphabet.is_en_letter(letter_shch)}")

    print(f"Приклад тексту: {EngAlphabet.example()}")
