require 'helper'

describe Pathfinder::NavigationSystem do
  let(:surface) { Pathfinder::Surfaces::SquareTable.new }
  let(:mobility_system) { Pathfinder::MobilitySystem.new }
  subject { described_class.new(surface, mobility_system) }

  context "by default" do
    it "should not be placed on the surface" do
      expect(subject.placed?).to eql(false)
    end
  end

  context "#initialize" do
    it "should store given surface" do
      expect(subject.surface).to eql(surface)
    end

    it "should store given mobility system" do
      expect(subject.mobility_system).to eql(mobility_system)
    end
  end

  describe "#move" do
    context "when robot isn't placed on the surface yet" do
      it "should NOT send request to the mobility module" do
        expect(subject.mobility_system).to_not receive(:move_by)
        subject.move
      end

      it "should call cancel_action" do
        expect(subject).to receive(:cancel_action).with("Robot isn't placed on the surface yet")
        subject.move
      end

      it "should return false" do
        expect(subject.move).to eq(false)
      end
    end

    context "when robot is already placed on the surface" do
      let(:position_on_surface) { Pathfinder::NavigationEntities::Position.new(3,3)  }
      let(:direction) { Pathfinder::NavigationEntities::Direction.new("NORTH")  }
      let(:placement_on_surface) { Pathfinder::NavigationEntities::Placement.new(position_on_surface, direction) }

      before do
        subject.place(*placement_on_surface.to_params)
      end

      it "should calculate target placement by adding direction vector to the current position" do
        expected_target_position = Pathfinder::NavigationEntities::Position.new(3,4)
        expect(subject.current_placement.position).to receive(:add).with([0, 1]).and_return(expected_target_position)
        expect(subject).to receive(:target_placement=)

        subject.move
      end

      it "should check whether target placement is on the surface" do
        expect(subject.surface).to receive(:position_on_surface?)
        subject.move
      end

      context "and target position is still on the given surface" do
        before do
          allow(subject.surface).to receive(:position_on_surface?).and_return(true)
        end

        it "should send request to the mobility module" do
          expect(subject.mobility_system).to receive(:move_by).with([0, 1])
          subject.move
        end

        it "should update robot placement information" do
          expect(subject).to receive(:update_placement)
          subject.move
        end
      end

      context "but the target position isn't on the given surface" do
        before do
          allow(subject.surface).to receive(:position_on_surface?).and_return(false)
        end

        it "should NOT send request to the mobility module" do
          expect(subject.mobility_system).to_not receive(:move_by)
          subject.move
        end

        it "should call cancel_action" do
          expect(subject).to receive(:cancel_action).with("Robot can't drive outside the surface")
          subject.move
        end
      end
    end
  end

  describe "#left" do
    context "when robot isn't placed on the surface yet" do
      it "should NOT send request to the mobility module" do
        expect(subject.mobility_system).to_not receive(:rotate_to)
        subject.left
      end

      it "should call cancel_action" do
        expect(subject).to receive(:cancel_action).with("Robot isn't placed on the surface yet")
        subject.left
      end

      it "should return false" do
        expect(subject.left).to eq(false)
      end
    end

    context "when robot is already placed on the surface" do
      let(:position_on_surface) { Pathfinder::NavigationEntities::Position.new(3,3)  }
      let(:direction) { Pathfinder::NavigationEntities::Direction.new("NORTH")  }
      let(:placement_on_surface) { Pathfinder::NavigationEntities::Placement.new(position_on_surface, direction) }

      before do
        subject.place(*placement_on_surface.to_params)
      end

      it "should send request to the mobility module" do
        expect(subject.mobility_system).to receive(:rotate_to).with([-1, 0])
        subject.left
      end

      it "should update robot placement information" do
        expect(subject).to receive(:update_placement)
        subject.left
      end
    end
  end

  describe "#right" do
    context "when robot isn't placed on the surface yet" do
      it "should NOT send request to the mobility module" do
        expect(subject.mobility_system).to_not receive(:rotate_to)
        subject.left
      end

      it "should call cancel_action" do
        expect(subject).to receive(:cancel_action).with("Robot isn't placed on the surface yet")
        subject.left
      end

      it "should return false" do
        expect(subject.left).to eq(false)
      end
    end

    context "when robot is already placed on the surface" do
      let(:position_on_surface) { Pathfinder::NavigationEntities::Position.new(3,3)  }
      let(:direction) { Pathfinder::NavigationEntities::Direction.new("NORTH")  }
      let(:placement_on_surface) { Pathfinder::NavigationEntities::Placement.new(position_on_surface, direction) }

      before do
        subject.place(*placement_on_surface.to_params)
      end

      it "should send request to the mobility module" do
        expect(subject.mobility_system).to receive(:rotate_to).with([1, 0])
        subject.right
      end

      it "should update robot placement information" do
        expect(subject).to receive(:update_placement)
        subject.right
      end
    end
  end

  describe "#place" do
    let(:position_on_surface) { Pathfinder::NavigationEntities::Position.new(3,3)  }
    let(:position_outside_surface) { Pathfinder::NavigationEntities::Position.new(3,6)  }
    let(:direction) { Pathfinder::NavigationEntities::Direction.new("NORTH")  }
    let(:placement_on_surface) { Pathfinder::NavigationEntities::Placement.new(position_on_surface, direction) }
    let(:placement_outside_surface) { Pathfinder::NavigationEntities::Placement.new(position_outside_surface, direction) }

    it "should check whether target placement is on the surface" do
      expect(subject.surface).to receive(:position_on_surface?) do |position|
        expect(position.x).to eq(placement_on_surface.position.x)
        expect(position.y).to eq(placement_on_surface.position.y)
      end
      subject.place(*placement_on_surface.to_params)
    end

    context "when target position is on the given surface" do
      it "should call update placement" do
        expect(subject).to receive(:update_placement) do |placement|
          expect(placement.to_params).to eq(placement_on_surface.to_params)
        end
        subject.place(*placement_on_surface.to_params)
      end
    end

    context "when the target position isn't on the given surface" do
      it "should NOT call update placement" do
        expect(subject).to_not receive(:update_placement)
        subject.place(*placement_outside_surface.to_params)
      end

      it "should call cancel_action" do
        expect(subject).to receive(:cancel_action).with("Robot can't be placed outside")
        subject.place(*placement_outside_surface.to_params)
      end
    end
  end

  describe "#placed?" do
    context "when robot's current_placement is nil" do
      it "should return true" do
        expect(subject.placed?).to eql(false)
      end
    end

    context "when robot's current_placement is not blank" do
      before :each do
        allow(subject).to receive(:current_placement).and_return(double('placement'))
      end

      it "should return true" do
        expect(subject.placed?).to eql(true)
      end
    end
  end


end
