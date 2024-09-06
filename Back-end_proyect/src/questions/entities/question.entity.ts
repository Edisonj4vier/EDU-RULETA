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
import { ApiProperty } from '@nestjs/swagger';

@Entity('questions')
export class Question {
  @ApiProperty({
    description: 'Identificador único de la pregunta',
    example: 'd1e9f16b-23b4-4c7f-9187-8fc8f76d8f6c',
    uniqueItems: true,
  })
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ApiProperty({
    description: 'Texto de la pregunta',
    example: '¿Cuál es la capital de Francia?',
  })
  @Column('text')
  enunciado: string;

  @ApiProperty({
    description: 'URL de un video explicativo para la pregunta',
    example: 'https://example.com/video.mp4',
    nullable: true,
  })
  @Column('text', { nullable: true })
  url_video_explicativo: string;

  @ApiProperty({
    description: 'Tema al que pertenece la pregunta',
    type: () => Topic,
  })
  @ManyToOne(() => Topic, (topic) => topic.questions, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'topic_id' })
  topic: Topic;

  @OneToMany(() => Answer, (answer) => answer.question)
  answers: Answer[];
}
