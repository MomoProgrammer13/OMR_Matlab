  function ratings = ratings(data,bool,templet)

Nsub   = size(data,2);   % Pega o numero de fontes


for n = 1:Nsub             
        p = 1;

        % Atribue os valores a partir do index dos blobs
        questions(1) = omr_get_rating(data(p,n), [3 11 21 35 52]);
        questions(2) = omr_get_rating(data(p,n), [4 14 22 36 53]);
        questions(3) = omr_get_rating(data(p,n), [1 12 23 37 51]);
        questions(4) = omr_get_rating(data(p,n), [2 15 24 38 54]);
        questions(5) = omr_get_rating(data(p,n), [5 16 25 39 55]);
        questions(6) = omr_get_rating(data(p,n), [6 13 26 40 56]);
        questions(7) = omr_get_rating(data(p,n), [7 17 27 41 57]);
        questions(8) = omr_get_rating(data(p,n), [8 18 28 42 58]);
        questions(9) = omr_get_rating(data(p,n), [9 19 29 43 59]);
        questions(10) = omr_get_rating(data(p,n), [10 20 30 44 60]);

        questions(11) = omr_get_rating(data(p,n), [105 111 122 132 148]);
        questions(12) = omr_get_rating(data(p,n), [101 119 123 133 141]);
        questions(13) = omr_get_rating(data(p,n), [106 112 124 134 142]);
        questions(14) = omr_get_rating(data(p,n), [107 113 125 135 143]);
        questions(15) = omr_get_rating(data(p,n), [108 114 126 131 144]);
        questions(16) = omr_get_rating(data(p,n), [109 115 127 136 149]);
        questions(17) = omr_get_rating(data(p,n), [110 116 128 137 150]);
        questions(18) = omr_get_rating(data(p,n), [102 117 129 138 145]);
        questions(19) = omr_get_rating(data(p,n), [103 120 130 139 146]);
        questions(20) = omr_get_rating(data(p,n), [104 118 121 140 147]);

        questions(21) = omr_get_rating(data(p,n), [192 213 226 231 241]);
        questions(22) = omr_get_rating(data(p,n), [191 211 221 232 242]);
        questions(23) = omr_get_rating(data(p,n), [193 214 227 233 243]);
        questions(24) = omr_get_rating(data(p,n), [194 215 222 234 244]);
        questions(25) = omr_get_rating(data(p,n), [195 216 223 235 245]);
        questions(26) = omr_get_rating(data(p,n), [196 217 228 236 246]);
        questions(27) = omr_get_rating(data(p,n), [197 218 229 237 247]);
        questions(28) = omr_get_rating(data(p,n), [198 212 224 238 248]);
        questions(29) = omr_get_rating(data(p,n), [199 219 230 239 249]);
        questions(30) = omr_get_rating(data(p,n), [200 220 225 240 250]);

        questions(31) = omr_get_rating(data(p,n), [31 61 71 81 91]);
        questions(32) = omr_get_rating(data(p,n), [32 62 72 82 92]);
        questions(33) = omr_get_rating(data(p,n), [33 63 73 83 93]);
        questions(34) = omr_get_rating(data(p,n), [45 64 74 84 94]);
        questions(35) = omr_get_rating(data(p,n), [46 65 75 85 95]);
        questions(36) = omr_get_rating(data(p,n), [47 66 76 86 96]);
        questions(37) = omr_get_rating(data(p,n), [34 67 77 87 97]);
        questions(38) = omr_get_rating(data(p,n), [48 68 78 88 98]);
        questions(39) = omr_get_rating(data(p,n), [49 69 79 89 99]);
        questions(40) = omr_get_rating(data(p,n), [50 70 80 90 100]);

        questions(41) = omr_get_rating(data(p,n), [153 165 171 181 201]);
        questions(42) = omr_get_rating(data(p,n), [154 166 172 182 202]);
        questions(43) = omr_get_rating(data(p,n), [155 167 173 183 203]);
        questions(44) = omr_get_rating(data(p,n), [151 161 174 184 204]);
        questions(45) = omr_get_rating(data(p,n), [156 168 175 185 205]);
        questions(46) = omr_get_rating(data(p,n), [157 162 176 186 206]);
        questions(47) = omr_get_rating(data(p,n), [158 163 177 187 207]);
        questions(48) = omr_get_rating(data(p,n), [152 169 178 188 208]);
        questions(49) = omr_get_rating(data(p,n), [159 164 179 189 209]);
        questions(50) = omr_get_rating(data(p,n), [160 170 180 190 210]);
        
        
        % Verifica se é as FR
        if bool
            correctAnswers = 0;
            for i = 1:50
                if isequal(questions(i),templet(1,i)) % Verifica se é o mesmo valor do gabarito
                    correctAnswers = correctAnswers + 1; 
                end
            end
            medium = (correctAnswers / 50) * 10; 
            disp(['A FR ' num2str(n)  ' acertou '  num2str(correctAnswers)  ' de 50 questões com uma nota de '  num2str(medium)]);
        end

end

% Salva os resultados
ratings = questions; 

end