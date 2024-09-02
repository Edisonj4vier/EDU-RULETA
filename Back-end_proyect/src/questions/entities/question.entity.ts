import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  OneToMany,
} from 'typeorm';
import { Topic } from '../../topics/entities/topic.entity'; // Asegúrate de que la ruta de importación sea correcta
import { Answer } from './answer.entity';

@Entity('questions')
export class Question {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column('text')
  enunciado: string;

  @Column('text', { nullable: true })
  url_video_explicativo: string;

  @ManyToOne(() => Topic, (topic) => topic.questions, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'topic_id' })
  topic: Topic;

  @OneToMany(() => Answer, (answer) => answer.question)
  answers: Answer[];
}
