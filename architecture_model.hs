import Text.ParserCombinators.Parsec

main = do
 f <- readFile "projet3A.txt"
 let (Right m) = (parse ifc "" f)
 putStrLn m

ifc :: Parser Model
ifc = many entry

entry = do
 string "#"
 number_of_entry <- integer
 string "="
 name_of_entry <- idt
 string "("
 ps <- params
 string ")"
 string ";"
 return (number_of_entry,name_of_entry,ps)
 
integer = many1 digit

params = do
 { epsilon; }
 <|> do {
	p <- param;
	c <- cont;
	return (p,c)}


param = do
 string "#"
 number_of_param <- integer
 return number_of_param
 <|> do
	id <- idt
	string "("
	ps <- params
	string ")"
	return (id,ps)
 <|> do
	string "'"
	txt <- text
	string "'"
	return txt

cont = do
	epsilon
	<|> do
	string ","
	p <- param
	c <- cont
	return (p,c)
	
idt = do
 identity <- many (letter <|> digit)
 return identity
 
text = do
 txt <- many letter
 return txt
 
epsilon = do 
 string ""