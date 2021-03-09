require_relative "../../lib/bowling"

describe "ボウリングのスコア計算" do
    before do
        @game = Bowling.new
    end
    describe "全体の合計" do
        context "すべての投球がガターだった場合" do
            it "0になること" do
                add_many_scores(20,0)
                expect(@game.total_score).to eq 0
            end
        end
        context "すべての投球で1ピンずつ倒した場合" do
            it "20になること" do
                add_many_scores(20,1)
                expect(@game.total_score).to eq 20
            end
        end
    end
end

private

def add_many_scores(count,pins)
    count.times do
        @game.add_score(pins)
    end
end